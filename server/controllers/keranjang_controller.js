const KeranjangModel = require("../models/keranjang_model")
const ProdukModel = require("../models/produk_model")

class KeranjangController {
  static keranjangRiwayatByUser(req, res) {
    const idUser = req.idUser

    // TODO: default exclude
    // TODO: include variasi
    KeranjangModel.findAll({
      include: [{
        model: ProdukModel,
        include: ["gambar"]
      }],
      where: { idUser }
    })
      .then((data) => {
        res.status(200).json({
          status: true,
          message: "Berhasil mengambil data keranjang",
          data: data,
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

  static updateKeranjang = (req, res) => {
    try {

      const idUser = req.idUser
      const listKeranjang = req.body
      
      this.updateKeranjangLocal(listKeranjang, idUser)

      res.status(200).json({
        status: true,
        message: "Berhasil update keranjang",
        data: {},
      })
      
    } catch (error) {
      console.log(error)
      res.status(500).json({
        status: false,
        message: "Terjadi kesalahan, silahkan coba lagi",
        data: {},
      })
    }
  }

  static async updateKeranjangLocal(listKeranjangRaw, idUser) {
    try {

      const listKeranjang = listKeranjangRaw.map(keranjang => {
        keranjang.idUser = idUser
        return keranjang
      })
  
      const keranjangBaru = listKeranjang.filter(keranjang => keranjang.id === null)
      const KeranjangLama = listKeranjang.filter(keranjang => keranjang.id !== null)
  
      await KeranjangModel.bulkCreate(keranjangBaru).catch((err) => console.log(err))
      
      const promises = KeranjangLama.map(keranjang => {
        return KeranjangModel.update(keranjang, {
          where: { id: keranjang.id }
        })
      })
      await Promise.allSettled(promises)
      
    } catch (error) {
      throw error
    }
  }
}

module.exports = KeranjangController