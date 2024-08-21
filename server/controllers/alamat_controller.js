const AlamatModel = require("../models/alamat_model")

class AlamatController {
  static tambahAlamat = (req, res) => {
    const { idUser } = req
    const { alamat } = req.body
    alamat.idUser = idUser

    AlamatModel.create(alamat)
      .then((data) => {
        res.status(201).json({
          status: true,
          message: "Berhasil menambahkan alamat",
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

  static updateAlamat = (req, res) => {
    const { idUser } = req
    const { alamat } = req.body
    const { id } = alamat
    delete alamat.id

    AlamatModel.update(alamat, {
      where: { id, idUser }
    })
      .then((_) => {
        res.status(200).json({
          status: true,
          message: "Berhasil mengubah alamat",
          data: {},
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

  static hapusAlamat = (req, res) => {
    const { idUser } = req
    const { id } = req.params

    AlamatModel.destroy({
      where: { id, idUser }
    })
      .then((_) => {
        res.status(200).json({
          status: true,
          message: "Berhasil menghapus alamat",
          data: {},
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

module.exports = AlamatController
