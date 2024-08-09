const { defaultExclude } = require("../constants")
const OrderModel = require("../models/order_model")
const VariasiModel = require("../models/variasi_model")
const { midtransBaseUrl } = require("../utils/constants")
const KeranjangController = require("./keranjang_controller")

class OrderController {
  static bankTransfers = ["bca", "bni", "bri", "cimb"]

  static createOrder = async (req, res) => {
    try {
      const { order: orderData, keranjang: listKeranjangRaw} = req.body
      const idUser = req.idUser

      const order = await OrderModel.create({ ...orderData, idUser })
      
      const serverKey = process.env.MIDTRANS_SERVER_KEY
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
        expiredAt
      } = midtransVaNumbers

      order.billKey = billKey
      order.billerCode = billerCode
      order.vaNumber = vaNumber
      order.expiredAt = expiredAt

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
        raw: true,
        nest: true,
        include: ["metodePembayaran"],
      })

      const bayarDetails = {}
      if (newOrder.vaNumber !== null) {
        bayarDetails["VA Number"] = newOrder.vaNumber
      }
      if (newOrder.billKey !== null) {
        bayarDetails["Bill Key"] = newOrder.billKey
      }
      if (newOrder.billerCode !== null) {
        bayarDetails["Biller Code"] = newOrder.billerCode
      }

      res.status(201).json({
        status: true,
        message: "Berhasil membuat order",
        data: {
          ...newOrder,
          bayarDetails,
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
    let billKey = null
    let billerCode = null
    let vaNumber = null

    if (jsonData["status_code"] !== "201") {
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

    return { billKey, billerCode, vaNumber, expiredAt }
  }
}

module.exports = OrderController