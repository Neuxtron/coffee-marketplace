const { Op } = require("sequelize")
const PesanModel = require("../models/pesan_model")

class PesanController {
  static allPesan(req, res) {
    const idUser = req.idUser
    
    PesanModel.findAll({
      where: {
        [Op.or]: [{ pengirim: idUser }, { penerima: idUser }]
      }
    })
      .then((data) => {
        res.status(200).json({
          status: true,
          message: "Berhasil mengambil data pesan",
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

  static createPesan(req, res) {
    const pesan = req.body
    const idUser = req.idUser

    PesanModel.create({ ...pesan, pengirim: idUser })
      .then((pesan) => {
        const data = pesan.get({ plain: true })
        delete data.updatedAt
        
        res.status(201).json({
          status: true,
          message: "Berhasil mengirim pesan",
          data,
        })
      })
      .catch((error) => {
        console.log(error)
        res.status(500).json({
          status: false,
          message: "Terjadi kesalahan, silahkan coba lagi",
          data: {},
        })
      })
  }

  static readPesan(req, res) {
    const idUser = req.idUser
    const { id } = req.body
    const tglBaca = new Date()

    PesanModel.update({ tglBaca }, {
      where: {
        [Op.and]: [{ id }, { penerima: idUser }]
      }
    })
      .then((_) => {
        res.status(200).json({
          status: true,
          message: "Berhasil membaca pesan",
          data: {},
        })
      })
      .catch((error) => {
        console.log(error)
        res.status(500).json({
          status: false,
          message: "Terjadi kesalahan, silahkan coba lagi",
          data: {},
        })
      })
  }

  static deletePesan(req, res) {
    const idUser = req.idUser
    const { id } = req.body
    const tglHapus = new Date()

    PesanModel.update({ tglHapus }, {
      where: {
        [Op.and]: [{ id }, { pengirim: idUser }]
      }
    })
      .then((_) => {
        res.status(200).json({
          status: true,
          message: "Berhasil menghapus pesan",
          data: {},
        })
      })
      .catch((error) => {
        console.log(error)
        res.status(500).json({
          status: false,
          message: "Terjadi kesalahan, silahkan coba lagi",
          data: {},
        })
      })
  }
}

module.exports = PesanController
