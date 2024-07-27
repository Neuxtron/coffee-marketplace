const { defaultExclude } = require("../constants")
const KeranjangModel = require("../models/keranjang_model")

class KeranjangController {
  static keranjangRiwayatByUser(req, res) {
    const idUser = req.idUser

    KeranjangModel.findAll({
      include: [
        {
          association: "produk",
          include: ["gambar", "variasi"]
        },
        "variasi",
      ],
      attributes: defaultExclude,
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
  
      await KeranjangModel.bulkCreate(keranjangBaru.map(keranjang => {
        delete keranjang.id
        return keranjang
      }))
        .catch((err) => console.log(err))
      
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

  static hapusKeranjang(req, res) {
    const { id } = req.params
    const { idUser } = req

    KeranjangModel.destroy({
      where: { id, idUser }
    })
      .then((_) => {
        res.status(200).json({
          status: true,
          message: "Berhasil menghapus data keranjang",
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

module.exports = KeranjangController