const express = require("express")
const router = express.Router()
const ProdukController = require("../controllers/produk_controller")
const authentication = require("../middlewares/authentication")

router.get("/", ProdukController.allProduk)
// router.get("/best_sellers", ProdukController.bestSellers)
router.post("/", authentication, ProdukController.createProduk)

module.exports = router