const express = require("express")
const router = express.Router()
const ProdukController = require("../controllers/produk_controller")

router.get("/", ProdukController.allProduk)
// router.get("/best_sellers", ProdukController.bestSellers)

module.exports = router