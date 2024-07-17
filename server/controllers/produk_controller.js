const { defaultExclude } = require("../constants")
const ProdukModel = require("../models/produk_model")

class ProdukController {
  static allProduk = (req, res) => {
    ProdukModel.findAll({
      include: [
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
      ],
      attributes: defaultExclude
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

  // TODO: best seller
}

module.exports = ProdukController
