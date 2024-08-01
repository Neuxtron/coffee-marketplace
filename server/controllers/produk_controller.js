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
}

module.exports = ProdukController
