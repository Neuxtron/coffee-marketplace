const { STRING, UUIDV4 } = require("sequelize")
const sequelize = require("../config/database")

const AlamatModel = sequelize.define("alamat", {
  id: {
    type: STRING,
    defaultValue: UUIDV4,
    primaryKey: true,
  },
  idUser: {
    type: STRING,
    allowNull: false,
  },
  idKecamatan: {
    type: STRING,
    allowNull: false,
  },
  idProvinsi: {
    type: STRING,
    allowNull: false,
  },
  alamat: {
    type: STRING,
    allowNull: false,
  },
}, {
  freezeTableName: true,
})

module.exports = AlamatModel