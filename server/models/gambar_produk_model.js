const { STRING, UUIDV4 } = require("sequelize")
const sequelize = require("../config/database")

const GambarProdukModel = sequelize.define("gambar_produk", {
  id: {
    type: STRING,
    defaultValue: UUIDV4,
    primaryKey: true,
  },
  fileName: {
    type: STRING,
    allowNull: false,
  },
  idProduk: {
    type: STRING,
    allowNull: false,
  },
}, {
  freezeTableName: true,
})

module.exports = GambarProdukModel