const { STRING, INTEGER, UUIDV4 } = require("sequelize")
const sequelize = require("../config/database")
const ProdukModel = require("./produk_model")
const UserModel = require("./users_model")
const VariasiModel = require("./variasi_model")

const KeranjangModel = sequelize.define("keranjang", {
  id: {
    type: STRING,
    defaultValue: UUIDV4,
    allowNull: false,
    primaryKey: true,
  },
  idUser: {
    type: STRING,
    allowNull: false,
  },
  idProduk: {
    type: STRING,
    allowNull: false,
  },
  idVariasi: {
    type: STRING,
    allowNull: false,
  },
  amount: {
    type: INTEGER,
    allowNull: false,
  },
  // idOrder: {
  //   type: STRING,
  //   allowNull: true,
  // },
}, {
  freezeTableName: true,
})

KeranjangModel.belongsTo(ProdukModel, { as: "produk", foreignKey: "idProduk", onDelete: "CASCADE" })
KeranjangModel.belongsTo(VariasiModel, { as: "variasi", foreignKey: "idVariasi", onDelete: "CASCADE" })
KeranjangModel.belongsTo(UserModel, { foreignKey: "idUser", onDelete: "CASCADE" })

module.exports = KeranjangModel