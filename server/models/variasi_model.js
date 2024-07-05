const { STRING, UUIDV4, INTEGER } = require("sequelize")
const sequelize = require("../config/database")

const VariasiModel = sequelize.define("variasi", {
  id: {
    type: STRING,
    defaultValue: UUIDV4,
    primaryKey: true,
  },
  nama: {
    type: STRING,
    allowNull: false,
  },
  stok: {
    type: INTEGER,
    allowNull: false,
  },
  idProduk: {
    type: STRING,
    allowNull: false,
  },
}, {
  freezeTableName: true,
})

module.exports = VariasiModel