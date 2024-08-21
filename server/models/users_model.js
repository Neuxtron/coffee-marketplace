const { INTEGER, STRING, UUIDV4 } = require("sequelize")
const sequelize = require("../config/database")
const bcrypt = require("bcrypt")
const { saltRounds } = require("../utils/constants")
const AlamatModel = require("./alamat_model")

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
  password: {
    type: STRING,
    allowNull: false,
  },
  token: {
    type: STRING,
    allowNull: true,
  },
  
  saldo: {
    type: INTEGER,
    allowNull: false,
    defaultValue: 0,
  },
  idKecamatanToko: {
    type: STRING,
    allowNull: true,
  },
  namaToko: {
    type: STRING,
    allowNull: true,
  },
  role: {
    type: STRING,
    allowNull: false,
    defaultValue: "pelanggan"
  },
  kodeOTP: {
    type: STRING,
    allowNull: true,
  },
}, {
  freezeTableName: true,
  hooks: {
    beforeCreate(user, options) {
      user.password = bcrypt.hashSync(user.password, saltRounds)
    }
  }
})

UserModel.hasMany(AlamatModel, { as: "alamat", foreignKey: "idUser", onDelete: "CASCADE" })

module.exports = UserModel