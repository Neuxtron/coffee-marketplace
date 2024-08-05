const { STRING, UUIDV4, TEXT, DATE } = require("sequelize")
const sequelize = require("../config/database")

const PesanModel = sequelize.define("pesan", {
  id: {
    type: STRING,
    defaultValue: UUIDV4,
    primaryKey: true,
  },
  pengirim: {
    type: STRING,
    allowNull: false,
  },
  penerima: {
    type: STRING,
    allowNull: false,
  },
  isi: {
    type: TEXT,
    allowNull: false,
  },
  tglBaca: {
    type: DATE,
    allowNull: true,
  },
  tglHapus: {
    type: DATE,
    allowNull: true,
  },
}, {
  freezeTableName: true,
})

module.exports = PesanModel