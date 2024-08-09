const GambarProdukModel = require("../models/gambar_produk_model")
const fs = require("fs")
const ProdukModel = require("../models/produk_model")

class GambarProdukController {
  static uploadGambarProduk(req, res) {
    const { idProduk } = req.body
    const file = req.file
    const fileName = file.filename

    if (!req.file) {
      return res.status(400).json({
        status: false,
        message: "Tidak ada file yang di upload",
        data: {},
      })
    }

    GambarProdukModel.create({ fileName, idProduk })
      .then((_) => {
        res.status(201).json({
          status: true,
          message: "Gambar produk berhasil di upload",
          data: {
            file: fileName
          },
        })
      })
      .catch((error => {
        console.log(error)
        fs.unlink(file.path)
        res.status(500).json({
          status: false,
          message: "Terjadi kesalahan, silahkan coba lagi",
          data: {},
        })
      }))
  }

  static async updateGambarProduk(req, res) {
    const { idProduk } = req.body
    const file = req.file
    const fileName = file.filename

    if (!req.file) {
      return res.status(400).json({
        status: false,
        message: "Tidak ada file yang di upload",
        data: {},
      })
    }

    const fileLama = (await GambarProdukModel.findOne({
      where: { idProduk }
    })).fileName
    fs.unlink(`images/uploads/${fileLama}`, (error) => {
      if (error) console.log(error)
    })

    GambarProdukModel.update({ fileName }, {
      where: { idProduk }
    })
      .then((_) => {
        res.status(200).json({
          status: true,
          message: "Gambar produk berhasil di update",
          data: {
            file: fileName
          },
        })
      })
      .catch((error => {
        console.log(error)
        fs.unlink(file.path)
        res.status(500).json({
          status: false,
          message: "Terjadi kesalahan, silahkan coba lagi",
          data: {},
        })
      }))
  }
}

module.exports = GambarProdukController
