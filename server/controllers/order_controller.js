const { Op } = require("sequelize")
const { defaultExclude } = require("../constants")
const KeranjangModel = require("../models/keranjang_model")
const OrderModel = require("../models/order_model")
const ProdukModel = require("../models/produk_model")
const VariasiModel = require("../models/variasi_model")
const { midtransBaseUrl } = require("../utils/constants")
const KeranjangController = require("./keranjang_controller")
const serverKey = process.env.MIDTRANS_SERVER_KEY

class OrderController {
  static bankTransfers = ["bca", "bni", "bri", "cimb"]
  static statusMessages = {
    "pending": "Menunggu pembayaran",
    "settlement": "Pesanan sedang dikemas",
    "deny": "Pembayaran ditolak",
    "cancel": "Pesanan dibatalkan",
    "expire": "Pembayaran kadaluarsa",

    "dikirim": "Pesanan dalam perjalanan",
    "diterima": "Pesanan sudah sampai ke tujuan",
    "selesai": "Pesanan selesai",
  }
  static tahapStatus = [
    "pending",
    "settlement",
    "dikirim",
    "diterima",
    "selesai",
  ]

  static createOrder = async (req, res) => {
    try {
      const { order: orderData, keranjang: listKeranjangRaw} = req.body
      const idUser = req.idUser

      const order = await OrderModel.create({ ...orderData, idUser })
      
      const body = this.midtransReqBody(
        orderData.metodeBayar,
        order.id,
        orderData.ongkir + orderData.subtotal
      )
      
      const response = await fetch(`${midtransBaseUrl}/charge`, {
        headers: {
          "Authorization": `Basic ${btoa(serverKey)}`,
          "Content-Type": "application/json"
        },
        method: "POST",
        body: JSON.stringify(body),
      })

      const midtransVaNumbers = await this.midtransVaNumber(response, orderData.metodeBayar)

      if (midtransVaNumbers === null) {
        throw new Error("Invalid Midtrans response")
      }

      const {
        billKey,
        billerCode,
        vaNumber,
        expiredAt,
        status,
      } = midtransVaNumbers

      order.billKey = billKey
      order.billerCode = billerCode
      order.vaNumber = vaNumber
      order.expiredAt = expiredAt
      order.status = status

      await order.save()
      
      const listKeranjang = listKeranjangRaw.map(keranjang => {
        keranjang.idOrder = order.id
        return keranjang
      })
      
      const promises = listKeranjang.map(async (keranjang) => {
        const variasi = await VariasiModel.findByPk(keranjang.idVariasi)
        variasi.stok -= keranjang.amount
        await variasi.save()
      })

      await Promise.allSettled(promises)
      await KeranjangController.updateKeranjangLocal(listKeranjang, idUser)

      const newOrder = await OrderModel.findByPk(order.id, {
        attributes: defaultExclude,
        raw: true, nest: true, 
        include: ["metodePembayaran"],
      })

      const bayarDetails = this.getBayarDetails(newOrder)
      const statusMessage = this.statusMessages[status]

      res.status(201).json({
        status: true,
        message: "Berhasil membuat order",
        data: {
          ...newOrder,
          bayarDetails,
          statusMessage,
        },
        // data: {},
      })
    } catch (err) {
      console.log(err)
      res.status(500).json({
        status: false,
        message: "Terjadi kesalahan, silahkan coba lagi",
        data: {},
      })
    }
  }

  static getBayarDetails(order) {
    const bayarDetails = {}
    if (order.vaNumber !== null) {
      bayarDetails["VA Number"] = order.vaNumber
    }
    if (order.billKey !== null) {
      bayarDetails["Bill Key"] = order.billKey
    }
    if (order.billerCode !== null) {
      bayarDetails["Biller Code"] = order.billerCode
    }
    return bayarDetails
  }

  static midtransReqBody(metodeBayar, idOrder, jumlah) {
    const request = {
      "payment_type": metodeBayar,
      "transaction_details": {
        "order_id": idOrder,
        "gross_amount": jumlah,
      },
    }
  
    // IDEA: no additional for permata 
    // if (metodeBayar === "permata") return request
  
    if (metodeBayar === "echannel") {
      request["echannel"] = {
        "bill_info1": "Pembayaran: ",
        "bill_info2": "Pembelian online",
      }
    }
  
    if (this.bankTransfers.includes(metodeBayar)) {
      request["payment_type"] = "bank_transfer"
      request["bank_transfer"] = { "bank": metodeBayar }
    }
    return request
  }

  static async midtransVaNumber(response, metodeBayar) {
    const jsonData = await response.json()
    const expiredAt = jsonData["expiry_time"]
    const status = jsonData["transaction_status"]
    const validCodes = ["201", "407", "200", "202"]
    
    let billKey = null
    let billerCode = null
    let vaNumber = null

    if (!validCodes.includes(jsonData["status_code"])) {
      console.log(jsonData)
      return null
    }

    if (metodeBayar === "permata") {
      vaNumber = jsonData["permata_va_number"]
    }

    if (metodeBayar === "echannel") {
      billKey = jsonData["bill_key"]
      billerCode = jsonData["biller_code"]
    }

    if (this.bankTransfers.includes(metodeBayar)) {
      vaNumber = jsonData["va_numbers"][0]["va_number"]
    }

    return { billKey, billerCode, vaNumber, expiredAt, status }
  }

  static riwayatOrder = (req, res) => {
    const { idUser } = req

    OrderModel.findAll({
      where: { idUser },
      include: [
        "metodePembayaran",
        {
          association: "keranjang",
          include: [
            {
              association: "produk",
              include: [
                "gambar",
                "variasi",
                {
                  association: "penjual",
                  attributes: ["id", "namaToko", "idKecamatanToko"],
                },
              ],
            },
            "variasi",
          ],
        }
      ],
      order: [["createdAt", "DESC"]]
    })
      .then(async (raw) => {
        const promises = raw.map(async (order) => {
          if (order.status == "pending") {
            const request = fetch(`${midtransBaseUrl}/${order.id}/status`, {
              headers: {
                "Authorization": `Basic ${btoa(serverKey)}`,
              },
            })
            const response = await request
            const vaNumbers = await this.midtransVaNumber(response, order.metodeBayar)
            if (vaNumbers == null) return

            const { status } = vaNumbers
            order.status = status
            await order.save()
          }
          const bayarDetails = this.getBayarDetails(order)
          const statusMessage = this.statusMessages[order.status]

          return {
            ...order.get(),
            bayarDetails,
            statusMessage,
          }
        })

        const data = (await Promise.allSettled(promises)).map(result => {
          return result.value
        })
        
        res.status(200).json({
          status: true,
          message: "Berhasil mengambil riwayat order",
          data,
        })
      })
      .catch((err) => {
        console.log(err)
        res.status(500).json({
          status: false,
          message: "Terjadi kesalahan, silahkan coba lagi",
          data: {},
        })
      })
  }

  static nextStatus = async (req, res) => {
    try {
      const { id, status: statusRaw, resi: resiRaw } = req.body

      const pesan = await OrderModel.findByPk(id)

      const listTolak = ["pending", "selesai"]
      if (listTolak.includes(pesan.status)) {
        return res.status(403).json({
          status: false,
          message: "Permintaan ditolak",
          data: {},
        })
      }

      const index = this.tahapStatus.indexOf(pesan.status)
      const status =  statusRaw ?? this.tahapStatus[index + 1]
      const resi = resiRaw ?? pesan.resiPengiriman
      await pesan.update({ status, resiPengiriman: resi })

      res.status(200).json({
        status: true,
        message: "Berhasil mengupdate status pesanan",
        data: {},
      })
    } catch (err) {
      console.log(err)
      res.status(500).json({
        status: false,
        message: "Terjadi kesalahan, silahkan coba lagi",
        data: {},
      })
    }
  }

  static riwayatPesananPenjual = async (req, res) => {
    try {
      const { idUser: idPenjual } = req
  
      const listIdProduk = []
      const listProduk = await ProdukModel.findAll({
        where: { idPenjual },
        raw: true,
        attributes: ["id"],
      })
      listProduk.forEach(produk => {
        listIdProduk.push(produk.id)
      })

      const listIdOrder = []
      const listKeranjang = await KeranjangModel.findAll({
        where: {
          [Op.not]: { idOrder: null },
          idProduk: listIdProduk,
        },
        raw: true,
        attributes: ["idOrder"],
      })
      listKeranjang.forEach(keranjang => {
        listIdOrder.push(keranjang.idOrder)
      })

      const exludeStatus = ["pending", "expire", "deny"]
      const listOrder = await OrderModel.findAll({
        where: {
          id: listIdOrder,
          [Op.not]: { status: exludeStatus }
        },
        // raw: true, nest: true,
        include: [
          "metodePembayaran",
          {
            association: "keranjang",
            include: [
              {
                association: "produk",
                include: [
                  "gambar",
                  "variasi",
                  {
                    association: "penjual",
                    attributes: ["id", "namaToko", "idKecamatanToko"],
                  },
                ],
              },
              "variasi",
            ],
          },
          "pembeli",
        ],
        order: [["createdAt", "DESC"]]
      })

      const data = listOrder.map(order => {
        const bayarDetails = this.getBayarDetails(order)
        const statusMessage = this.statusMessages[order.status]

        return { ...order.get(), bayarDetails, statusMessage }
      })

      res.status(200).json({
        status: true,
        message: "Berhasil mengambil riwayat pesanan penjual",
        data,
      })
    } catch (err) {
      console.log(err)
      res.status(500).json({
        status: false,
        message: "Terjadi kesalahan, silahkan coba lagi",
        data: {},
      }) 
    }
  }

  // TODO: api tracking
}

module.exports = OrderController