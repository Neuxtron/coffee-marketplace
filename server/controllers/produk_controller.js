const { defaultExclude } = require("../constants")
const GambarProdukModel = require("../models/gambar_produk_model")
const ProdukModel = require("../models/produk_model")
const VariasiModel = require("../models/variasi_model")
const fs = require("fs")

const getInclude = [
  {
    association: "gambar",
    attributes: {
      exclude: [...defaultExclude.exclude, "idProduk"]
    },
  },
  {
    association: "variasi",
    attributes: {
      exclude: [...defaultExclude.exclude, "idProduk"]
    },
  },
  {
    association: "penjual",
    attributes: ["id", "namaToko", "idKecamatanToko"],
  },
]

class ProdukController {
  static allProduk = (req, res) => {
    // TODO: pagination
    // TODO: thumbnail
    ProdukModel.findAll({
      include: getInclude,
      attributes: defaultExclude,
      order: [["createdAt", "DESC"]]
    })

      .then((data) => {
        res.status(200).json({
          status: true,
          message: "Berhasil mengambil data produk",
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
  static getThumbnail(listGambar) {
    if (listGambar.length === 0) return null
    return listGambar[0]
  }

  static bestSellers = (req, res) => {
    // TODO: produk terbanyak terjual
  }

  static createProduk = async (req, res) => {
    const { idUser: idPenjual, role } = req
    const { produk } = req.body
    delete produk.id

    if (role !== "penjual") {
      res.status(401).json({
        status: false,
        message: "Akses ditolak",
        data: {}
      })
      return
    }

    const produkBalu = await ProdukModel.create({ ...produk, idPenjual })
    ProdukModel.findByPk(produkBalu.id, {
      include: getInclude,
      attributes: defaultExclude,
      order: [["createdAt", "DESC"]],
    })
      .then((data) => {
        this.updateVariasiLocal(produk.variasi, produkBalu.id)
        res.status(201).json({
          status: true,
          message: "Berhasil menambahkan produk",
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

  static updateProduk = (req, res) => {
    const { idUser: idPenjual, role } = req
    const { produk } = req.body
    const { id } = produk
    delete produk.id

    if (role !== "penjual") {
      res.status(401).json({
        status: false,
        message: "Akses ditolak",
        data: {}
      })
      return
    }

    ProdukModel.update({ ...produk, idPenjual }, {
      where: { id }
    })
      .then((_) => {
        this.updateVariasiLocal(produk.variasi, id)
        res.status(200).json({
          status: true,
          message: "Berhasil mengupdate produk",
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

  static async updateVariasiLocal(listVariasiRaw, idProduk) {
    try {
      const listIdVariasi = []
      listVariasiRaw.forEach(variasi => {
        if (variasi.id) {
          listIdVariasi.push(variasi.id)
        }
      })
      const variasiExisting = await VariasiModel.findAll({
        where: { idProduk },
        attributes: ["id"],
        raw: true, nest: true,
      })
      const deletedIds = []
      variasiExisting.forEach(variasi => {
        if (!listIdVariasi.includes(variasi.id)) {
          deletedIds.push(variasi.id)
        }
      })

      await VariasiModel.destroy({
        where: {
          idProduk,
          id: deletedIds,
        }
      })

      const listVariasi = listVariasiRaw.map((variasi) => {
        variasi.idProduk = idProduk
        return variasi
      })

      const variasiBaru = listVariasi.filter(
        (variasi) => variasi.id === null
      )
      const variasiLama = listVariasi.filter(
        (variasi) => variasi.id !== null
      )

      await VariasiModel.bulkCreate(
        variasiBaru.map((variasi) => {
          delete variasi.id
          return variasi
        })
      ).catch((err) => console.log(err))

      const promises = variasiLama.map((variasi) => {
        return VariasiModel.update(variasi, {
          where: { id: variasi.id },
        })
      })
      await Promise.allSettled(promises)
    } catch (error) {
      throw error
    }
  }

  static async hapusProduk(req, res) {
    const { id } = req.params
    
    // TODO verify id penjual
    const gambarProduk = await GambarProdukModel.findAll({
      where: { idProduk: id },
      raw: true, nest: true,
    })
    const listGambar = gambarProduk.map(gambarItem => {
      return gambarItem.fileName
    })

    ProdukModel.destroy({
      where: { id }
    })
      .then((_) => {
        listGambar.forEach(gambar => {
          fs.unlink(`images/uploads/${gambar}`, (error) => {
            if (error) console.log(error)
          })
        })
        
        res.status(200).json({
          status: true,
          message: "Berhasil menghapus produk",
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

module.exports = ProdukController
