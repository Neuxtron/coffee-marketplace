const { UUIDV4, STRING, TEXT } = require("sequelize")
const sequelize = require("../config/database")
const UserModel = require("./users_model")

const PengajuanPakarModel = sequelize.define("pengajuan_pakar", {
  id: {
    type: STRING,
    defaultValue: UUIDV4,
    allowNull: false,
    primaryKey: true,
  },
  pesan: {
    type: TEXT,
    allowNull: false,
  },
  idUser: {
    type: STRING,
    allowNull: false,
  },
}, {
  freezeTableName: true,
})

PengajuanPakarModel.belongsTo(UserModel, { as: "pakar", foreignKey: "idUser", onDelete: "CASCADE" })

module.exports = PengajuanPakarModel