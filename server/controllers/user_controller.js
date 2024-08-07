const UserModel = require("../models/users_model")
const { secret } = require("../utils/constants")
const bcrypt = require("bcrypt")
const jwt = require("jsonwebtoken")
const { defaultExclude } = require("../constants")

class UserController {
  static getProfile(req, res) {
    const id = req.idUser

    UserModel.findOne({
      where: { id },
      attributes: defaultExclude
    })
      .then((user) => {
        res.status(200).json({
          status: true,
          message: "Berhasil mengambil profil user",
          data: user,
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

  static async registerUser(req, res) {
    try {

      const data = req.body
      const { email } = data

      const existingUser = await UserModel.findOne({
        where: { email }
      })
      if (existingUser) {
        res.status(409).json({
          status: false,
          message: "Email sudah terdaftar",
          data: {},
        })
        return
      }
  
      const user = await UserModel.create(data)
      const { id } = user
      const token = jwt.sign({ id }, secret)
      await user.update({ token })

      UserModel.findOne({
        where: { id },
        attributes: defaultExclude
      })
        .then((userData) => {
          res.status(200).json({
            status: true,
            message: "Berhasil menambahkan user",
            data: userData,
          })
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

  static async loginUser(req, res) {
    try {

      const { email, password } = req.body
  
      const user = await UserModel.findOne({
        where: { email },
      })
      if (user === null) {
        res.status(401).json({
          status: false,
          message: "Email belum terdafatr",
          data: {},
        })
        return
      }
  
      const validation = bcrypt.compareSync(password, user.password)
      if (!validation) {
        res.status(401).json({
          status: false,
          message: "Password yang Anda masukkan salah",
          data: {},
        })
        return
      }
  
      const id = user.id
      const token = jwt.sign({ id }, secret)
      await user.update({ token })

      UserModel.findOne({
        where: { id },
        attributes: defaultExclude
      })
        .then((data) => {
          res.status(200).json({
            status: true,
            message: "Berhasil login",
            data: data,
          })
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

  static logoutUser(req, res) {
    const id = req.idUser

    UserModel.update({ token: null }, {
      where: { id }
    })
      .then((_) => {
        res.status(200).json({
          status: true,
          message: "Berhasil logout",
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

  static allPakar(req, res) {
    UserModel.findAll({
      where: { role: "pakar" },
      attributes: ["id", "nama"]
    })
      .then((data) => {
        res.status(200).json({
          status: true,
          message: "Berhasil mengambil data pakar",
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

  // TODO: ubah password
}

module.exports = UserController