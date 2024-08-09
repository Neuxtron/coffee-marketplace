const { defaultExclude } = require("../constants")
const ProdukModel = require("../models/produk_model")

const getInclude = [
  {
    association: "gambar",
    attributes: {
      exclude: [...defaultExclude.exclude, "idProduk"]
    },
  },
  {
    association: "variasi",
    attributes: {
      exclude: [...defaultExclude.exclude, "idProduk"]
    },
  },
  {
    association: "penjual",
    attributes: ["id", "namaToko", "idKecamatanToko"],
  },
]

class ProdukController {
  static allProduk = (req, res) => {
    // TODO: pagination
    // TODO: thumbnail
    ProdukModel.findAll({
      include: getInclude,
      attributes: defaultExclude,
      order: [["createdAt", "DESC"]]
    })

      .then((data) => {
        res.status(200).json({
          status: true,
          message: "Berhasil mengambil data produk",
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
  static getThumbnail(listGambar) {
    if (listGambar.length === 0) return null
    return listGambar[0]
  }

  static bestSellers = (req, res) => {
    // TODO: produk terbanyak terjual
  }

  static async createProduk(req, res) {
    const { idUser: idPenjual, role } = req
    const { produk } = req.body

    if (role !== "penjual") {
      res.status(401).json({
        status: false,
        message: "Akses ditolak",
        data: {}
      })
      return
    }

    const produkBalu = await ProdukModel.create({ ...produk, idPenjual }, {
      include: ["variasi"]
    })
    ProdukModel.findByPk(produkBalu.id, {
      include: getInclude,
      attributes: defaultExclude,
      order: [["createdAt", "DESC"]],
    })
      .then((data) => {
        res.status(201).json({
          status: true,
          message: "Berhasil menambahkan produk",
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
}

module.exports = ProdukController
