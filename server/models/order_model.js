const { INTEGER, STRING, UUIDV4, DATE } = require("sequelize")
const sequelize = require("../config/database")
const UserModel = require("./users_model")
const MetodeBayarModel = require("./metode_bayar_model")
const KeranjangModel = require("./keranjang_model")

const OrderModel = sequelize.define("orders", {
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
  status: {
    type: STRING,
    allowNull: false,
    defaultValue: "pending",
  },
  subtotal: {
    type: INTEGER,
    allowNull: false,
  },
  ongkir: {
    type: INTEGER,
    allowNull: false,
  },
  metodeBayar: {
    type: STRING,
    allowNull: false,
  },
  vaNumber: {
    type: STRING,
    allowNull: true,
  },
  billKey: {
    type: STRING,
    allowNull: true,
  },
  billerCode: {
    type: STRING,
    allowNull: true,
  },
  expiredAt: {
    type: DATE,
    allowNull: true,
  },
  batasKonfirmasi: {
    type: DATE,
    allowNull: true,
  },
  resiPengiriman: {
    type: STRING,
    allowNull: true,
  },
}, {
  freezeTableName: true,
})

OrderModel.belongsTo(UserModel, { as: "pembeli", foreignKey: "idUser", onDelete: "CASCADE" })
OrderModel.belongsTo(MetodeBayarModel, { as: "metodePembayaran", foreignKey: "metodeBayar", onDelete: "RESTRICT" })
OrderModel.hasMany(KeranjangModel, { as: "keranjang", foreignKey: "idOrder", onDelete: "RESTRICT" })

module.exports = OrderModel