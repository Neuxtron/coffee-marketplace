const { STRING, UUIDV4, TEXT, INTEGER } = require("sequelize")
const sequelize = require("../config/database")
const KategoriModel = require("./kategori_model")
const GambarProdukModel = require("./gambar_produk_model")
const VariasiModel = require("./variasi_model")
const UserModel = require("./users_model")

const ProdukModel = sequelize.define("produk", {
  id: {
    type: STRING,
    defaultValue: UUIDV4,
    allowNull: false,
    primaryKey: true,
  },
  nama: {
    type: STRING,
    allowNull: false,
  },
  deskripsi: {
    type: TEXT,
    allowNull: false,
  },
  harga: {
    type: INTEGER,
    allowNull: false,
  },
  idKategori: {
    type: STRING,
    allowNull: false,
  },
  beratProduk: {
    type: INTEGER,
    allowNull: false,
  },
  merk: {
    type: STRING,
    allowNull: true,
  },
  idPenjual: {
    type: STRING,
    allowNull: false,
  },
}, {
  freezeTableName: true,
})

ProdukModel.belongsTo(KategoriModel, { foreignKey: "idKategori", onDelete: "CASCADE" })
ProdukModel.belongsTo(UserModel, { as: "penjual", foreignKey: "idPenjual", onDelete: "RESTRICT" })
ProdukModel.hasMany(GambarProdukModel, {
  as: "gambar",
  foreignKey: "idProduk",
  onDelete: "CASCADE"
})
ProdukModel.hasMany(VariasiModel, {
  as: "variasi",
  foreignKey: "idProduk",
  onDelete: "CASCADE"
})

module.exports = ProdukModel