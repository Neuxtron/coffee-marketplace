const { defaultExclude } = require("../constants")
const MetodeBayarModel = require("../models/metode_bayar_model")

class MetodeBayarController {
  static allMetode(req, res) {
    MetodeBayarModel.findAll({
      attributes: defaultExclude,
    })
      .then((data) => {
        res.status(200).json({
          status: true,
          message: "Berhasil mengambil data metode pembayaran",
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

module.exports = MetodeBayarController
