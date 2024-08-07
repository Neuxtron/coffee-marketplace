const { Op } = require("sequelize")
const PesanModel = require("../models/pesan_model")
const UserModel = require("../models/users_model")

class PesanController {
  static allPesan = (req, res) => {
    const idUser = req.idUser
    const where = {
      [Op.or]: [{ pengirim: idUser }, { penerima: idUser }]
    }
    
    this.markTerkirim(null, where, idUser)
      .then(async (data) => {
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

  static createPesan = async (req, res) => {
    const pesan = req.body
    const idUser = req.idUser

    const raw = await PesanModel.create({ ...pesan, pengirim: idUser })
    PesanModel.findByPk(raw.id, {
      include: [
        { association: "pengirimData", attributes: ["id", "role"] },
        { association: "penerimaData", attributes: ["id", "role"] },
      ],
      raw: true, nest: true,
    })
      .then((raw) => {
        const data = this.pesanPreResponse(raw, idUser)
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
        pengirim: id,
        penerima: idUser,
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
        id,
        pengirim: idUser,
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

  static getNewMessages = (req, res) => {
    const idUser = req.idUser
    const { listKirim } = req.body

    const where = {
      [Op.or]: [
        // {
        //   pengirim: idUser,
        //   tglTerkirim: null,
        // },
        {
          penerima: idUser,
          tglBaca: null,
        },
      ],
    }

    PesanModel.findAll({ where })
      .then(async (raw) => {
        const data = await this.markTerkirim(raw, where, idUser, listKirim)
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

  static markTerkirim = async (data, where, idUser, listKirim = []) => {
    const listIdPesan = []
    if (data) {
      data.forEach(pesan => {
        listIdPesan.push(pesan.id)
      });
    }

    const tglTerkirim = new Date()
    await PesanModel.update({ tglTerkirim }, {
      where: data ? { id: listIdPesan, ...where } : where
    })

    listIdPesan.push(...listKirim)
    const newWhere = {
      [Op.or]: [
        { pengirim: idUser },
        { penerima: idUser },
      ],
    }
    const newData = await PesanModel.findAll({
      where: data ? { id: listIdPesan, ...newWhere } : newWhere,
      include: [
        { association: "pengirimData", attributes: ["id", "role"] },
        { association: "penerimaData", attributes: ["id", "role"] },
      ],
      order: [["createdAt", "DESC"]],
      raw: true, nest: true,
    })

    return newData.map(pesan => this.pesanPreResponse(pesan, idUser))
  }

  static pesanPreResponse(pesan, idUser) {
    const { pengirimData: pengirim, penerimaData: penerima } = pesan
    delete pesan.pengirimData
    delete pesan.penerimaData

    if (pengirim.id === idUser) {
      pesan.role = penerima.role
      return pesan
    }
    pesan.role = pengirim.role
    return pesan
  }

  static async chatRooms(req, res) {
    try {
      const myId = req.idUser
      
      const listChatRoom = []
      const listPesan = await PesanModel.findAll({
        where: {
          [Op.or]: [{ pengirim: myId }, { penerima: myId }]
        },
        order: [["createdAt", "DESC"]],
      })

      for (let index = 0; index < listPesan.length; index++) {
        const pesan = listPesan[index];
        const idUser = pesan.pengirim === myId ? pesan.penerima : pesan.pengirim
        if (!listChatRoom.find(room => room.idUser === idUser)) {
          const user = await UserModel.findByPk(idUser)
          listChatRoom.push({
            idUser,
            namaUser: user.nama,
            role: user.role,
          })
        }
      }

      res.status(200).json({
        status: true,
        message: "Berhasil mengambil data chatroom",
        data: listChatRoom,
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
}

module.exports = PesanController
