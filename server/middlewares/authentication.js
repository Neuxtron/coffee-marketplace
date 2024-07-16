const jwt = require("jsonwebtoken")
const { secret } = require("../utils/constants")
const UserModel = require("../models/users_model")

async function authentication(req, res, next) {
  try {

    const bearer = req.headers.authorization
    if (bearer === undefined) throw new jwt.JsonWebTokenError("No headers found")
    const token = bearer.slice(7)
    console.log(token)
    
    const user = await UserModel.findOne({
      where: { token }
    })
    if (user === null) throw new jwt.JsonWebTokenError("User not found")
      
    const decode = jwt.verify(token, secret)
    req.idUser = decode.id
    next()

  } catch (error) {
    console.log(error)
    if (error instanceof jwt.JsonWebTokenError) {
      res.status(401).json({
        status: false,
        message: "Anda belum login",
        data: {}
      })
      return
    }
    res.status(500).json({
      status: false,
      message: "Terjadi kesalahan, silahkan coba lagi",
      data: {}
    })
  }
}

module.exports = authentication