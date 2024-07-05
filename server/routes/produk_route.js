const express = require("express")
const router = express.Router()
const ProdukController = require("../controllers/produk_controller")

router.get("/", ProdukController.allProduk)

module.exports = router