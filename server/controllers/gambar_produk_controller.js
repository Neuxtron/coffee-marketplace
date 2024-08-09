const GambarProdukModel = require("../models/gambar_produk_model")
const fs = require("fs")

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
}

module.exports = GambarProdukController
