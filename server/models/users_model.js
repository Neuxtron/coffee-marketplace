const { INTEGER, STRING, UUIDV4 } = require("sequelize")
const sequelize = require("../config/database")
const bcrypt = require("bcrypt")
const { saltRounds } = require("../utils/constants")

const UserModel = sequelize.define("user", {
  id: {
    type: STRING,
    defaultValue: UUIDV4,
    allowNull: false,
    primaryKey: true,
  },
  nama: {
    type: STRING,
    allowNull: false,
  },
  email: {
    type: STRING,
    allowNull: false,
  },
  noHp: {
    type: STRING,
    allowNull: false,
  },
  alamat: {
    type: STRING,
    allowNull: false,
  },
  password: {
    type: STRING,
    allowNull: false,
  },
  token: {
    type: STRING,
    allowNull: true,
  },
  idKecamatan: {
    type: STRING,
    allowNull: false,
  },
  // TODO: saldo
  // TODO: id kecamatan toko, jasa kirim yg tersedia
}, {
  freezeTableName: true,
  hooks: {
    beforeCreate(user, options) {
      user.password = bcrypt.hashSync(user.password, saltRounds)
    }
  }
})

module.exports = UserModel