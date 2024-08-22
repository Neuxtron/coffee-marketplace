const UserModel = require("../models/users_model")
const { secret } = require("../utils/constants")
const bcrypt = require("bcrypt")
const jwt = require("jsonwebtoken")
const { defaultExclude } = require("../constants")
const nodemailer = require("nodemailer")
const { saltRounds } = require("../utils/constants")

class UserController {
  static getProfile(req, res) {
    const id = req.idUser

    UserModel.findOne({
      where: { id },
      include: ["alamat"],
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
        include: ["alamat"],
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
        include: ["alamat"],
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

  static async requestUbahPassword(req, res) {
    const { email } = req.body
    const kodeOTP = Math.floor(Math.random() * 1000000)

    const rows = await UserModel.update({ kodeOTP }, {
      where: { email }
    }).catch((err) => {
      console.log(err)
      res.status(500).json({
        status: false,
        message: "Gagal ubah password: Internal server error",
        data: {},
      })
    })

    if (rows[0] === 0) {
      res.status(404).json({
        status: false,
        message: "Email Anda tidak terdaftar",
        data: {},
      })
      return
    }

    const emailPengirim = process.env.NODEMAILER_SENDER_EMAIL
    const passwordPengirim = process.env.NODEMAILER_SENDER_PASSWORD
    const hostPengirim = process.env.NODEMAILER_SENDER_HOST

    const transporter = nodemailer.createTransport(
      `smtp://${emailPengirim}:${passwordPengirim}@${hostPengirim}:587`
    );

    const mailOptions = {
      from: emailPengirim,
      to: email,
      subject: 'Ubah password Coffee Marketplace',
      text: `Kode OTP Anda adalah ${kodeOTP}`
    }

    transporter.sendMail(mailOptions, (error, info) => {
      if (error) {
        console.log(error);
        res.status(500).json({
          status: false,
          message: "Gagal kirim email: Internal server error",
          data: {},
        })
        return
      }
      res.status(200).json({
        status: true,
        message: "Kode OTP berhasil dikirim",
        data: {},
      })
    });
  }

  static checkOTP(req, res) {
    const { email, kodeOTP } = req.body

    UserModel.findOne({ where: { email, kodeOTP } })
      .then((data) => {
        if (data === null) {
          res.status(404).json({
            status: false,
            message: "Kode OTP salah",
            data: {},
          })
          return
        }
        res.status(200).json({
          status: true,
          message: "Email dan kode OTP sudah benar",
          data: {},
        })
      })
      .catch((err) => {
        console.log(err)
        res.status(500).json({
          status: false,
          message: "Gagal check OTP: Internal server error",
          data: {},
        })
      })
  }

  static ubahPasswordOTP(req, res) {
    const { email, kodeOTP, password: passwordRaw } = req.body
    const password = bcrypt.hashSync(passwordRaw, saltRounds)

    UserModel.update({ password, kodeOTP: null }, { where: { email, kodeOTP } })
      .then((rows) => {
        if (rows[0] === 0) {
          res.status(404).json({
            status: false,
            message: "Email atau kode OTP salah",
            data: {},
          })
          return
        }
        res.status(200).json({
          status: true,
          message: "Password berhasil diubah",
          data: {},
        })
      })
      .catch((err) => {
        console.log(err)
        res.status(500).json({
          status: false,
          message: "Gagal ubah password: Internal server error",
          data: {},
        })
      })
  }

  static requestKonfirmasiEmail = async (req, res) => {
    try {
      const { idUser: id } = req
      const user = await UserModel.findByPk(id)

      if (user.terkonfirmasi) {
        return res.status(403).json({
          status: false,
          message: "Email sudah terkonfirmasi",
          data: {},
        })
      }

      const kode = Math.floor(Math.random() * 1000000)
      await user.update({ kodeKonfirmasiEmail: kode })

      // TODO: === remove ===
      // return res.status(200).json({
      //   status: true,
      //   message: "Kode konfirmasi berhasil dikirim",
      //   data: {},
      // })
      // TODO: === remove ===
      
      const emailPengirim = process.env.NODEMAILER_SENDER_EMAIL
      const passwordPengirim = process.env.NODEMAILER_SENDER_PASSWORD
      const hostPengirim = process.env.NODEMAILER_SENDER_HOST

      const transporter = nodemailer.createTransport(
        `smtp://${emailPengirim}:${passwordPengirim}@${hostPengirim}:587`
      );

      const mailOptions = {
        from: emailPengirim,
        to: user.email,
        subject: 'Konfirmasi email Coffee Marketplace',
        text: `Kode konfirmasi Anda adalah ${kode}`
      }

      transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
          console.log(error);
          return res.status(500).json({
            status: false,
            message: "Terjadi kesalahan, silahkan coba lagi",
            data: {},
          })
        }
        return res.status(200).json({
          status: true,
          message: "Kode konfirmasi berhasil dikirim",
          data: {},
        })
      });
    } catch (err) {
      console.log(err)
      res.status(500).json({
        status: false,
        message: "Terjadi kesalahan, silahkan coba lagi",
        data: {},
      })
    }
  }

  static konfirmasiEmail = async (req, res) => {
    try {
      const { idUser: id } = req
      const { kodeKonfirmasi: kode } = req.body

      const user = await UserModel.findByPk(id)
      if (user.kodeKonfirmasiEmail !== kode) {
        return res.status(403).json({
          status: false,
          message: "Kode yang Anda masukkan salah",
          data: {},
        })
      }

      user.kodeKonfirmasiEmail = null
      user.terkonfirmasi = true
      await user.save()

      return res.status(200).json({
        status: true,
        message: "Email berhasil dikonfirmasi",
        data: {},
      })
    } catch (err) {
      console.log(err)
      return res.status(500).json({
        status: false,
        message: "Terjadi kesalahan, silahkan coba lagi",
        data: {},
      })
    }
  }
}

module.exports = UserController