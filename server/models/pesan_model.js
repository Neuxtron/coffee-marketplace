const { STRING, UUIDV4, TEXT, DATE } = require("sequelize")
const sequelize = require("../config/database")
const UserModel = require("./users_model")

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
  tglTerkirim: {
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

PesanModel.belongsTo(UserModel, { as: "pengirimData", foreignKey: "pengirim", onDelete: "CASCADE" })
PesanModel.belongsTo(UserModel, { as: "penerimaData", foreignKey: "penerima", onDelete: "CASCADE" })


module.exports = PesanModel