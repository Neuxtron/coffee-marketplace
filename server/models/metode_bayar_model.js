const { STRING } = require("sequelize")
const sequelize = require("../config/database")

const MetodeBayarModel = sequelize.define("metode_pembayaran", {
  id: {
    type: STRING,
    primaryKey: true,
  },
  nama: {
    type: STRING,
    allowNull: false,
  },
  imgFileName: {
    type: STRING,
    allowNull: false,
  },
}, {
  freezeTableName: true,
})

module.exports = MetodeBayarModel