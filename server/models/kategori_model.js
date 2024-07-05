const { DataTypes, UUIDV4 } = require("sequelize")
const sequelize = require("../config/database")

const KategoriModel = sequelize.define("kategori", {
  id: {
    type: DataTypes.STRING,
    defaultValue: UUIDV4,
    allowNull: false,
    primaryKey: true,
  },
  icon: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  nama: {
    type: DataTypes.STRING,
    allowNull: false,
  },
}, {
  freezeTableName: true,
})

module.exports = KategoriModel