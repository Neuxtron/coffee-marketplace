const { defaultExclude } = require("../constants")
const PengajuanPakarModel = require("../models/pengajuan_pakar_model")
const UserModel = require("../models/users_model")

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

  static async approvePengajuan(req, res) {
    try {
      const { role } = req
      const { id } = req.params

      if (role !== "admin") {
        res.status(401).json({
          status: false,
          message: "Akses ditolak",
          data: {}
        })
        return
      }
  
      const pengajuan = await PengajuanPakarModel.findByPk(id)
      await UserModel.update({ role: "pakar" }, {
        where: { id: pengajuan.idUser }
      })

      await PengajuanPakarModel.destroy({ where: { id } })

      res.status(200).json({
        status: true,
        message: "Pengajuan berhasil diterima",
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

  static async createPengajuan(req, res) {
    try {
      const { idUser } = req
      const { pengajuan } = req.body

      const existing = await PengajuanPakarModel.findOne({
        where: { idUser }
      })

      if (existing) {
        await PengajuanPakarModel.update({ ...pengajuan }, {
          where: { idUser }
        })
      } else {
        await PengajuanPakarModel.create({ ...pengajuan, idUser })
      }
      
      res.status(201).json({
        status: true,
        message: "Berhasil mengirim pengajuan pakar",
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
}

module.exports = PengajuanPakarController
