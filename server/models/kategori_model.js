const { UUIDV4, STRING } = require("sequelize")
const sequelize = require("../config/database")

const KategoriModel = sequelize.define("kategori", {
  id: {
    type: STRING,
    defaultValue: UUIDV4,
    allowNull: false,
    primaryKey: true,
  },
  icon: {
    type: STRING,
    allowNull: false,
  },
  nama: {
    type: STRING,
    allowNull: false,
  },
}, {
  freezeTableName: true,
})

module.exports = KategoriModel