const { defaultExclude } = require("../constants")
const KategoriModel = require("../models/kategori_model")

class KategoriController {
  static allKategori(req, res) {
    KategoriModel.findAll({
      attributes: defaultExclude
    })

      .then((data) => {
        res.status(200).json({
          status: true,
          message: "Berhasil mengambil data kategori",
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

module.exports = KategoriController
