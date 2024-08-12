const { defaultExclude } = require("../constants")
const PengajuanPakarModel = require("../models/pengajuan_pakar_model")

class PengajuanPakarController {
  static allPengajuan(req, res) {
    const { role } = req

    if (role !== "admin") {
      res.status(401).json({
        status: false,
        message: "Akses ditolak",
        data: {}
      })
      return
    }
    
    PengajuanPakarModel.findAll({
      attributes: defaultExclude,
      order: [["createdAt", "DESC"]],
      include: [{
        association: "pakar",
        attributes: ["id", "nama"],
      }],
    })

      .then((data) => {
        res.status(200).json({
          status: true,
          message: "Berhasil mengambil data pengajuan pakar",
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

module.exports = PengajuanPakarController
