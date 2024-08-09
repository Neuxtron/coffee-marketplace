const express = require("express")
const router = express.Router()
const ProdukController = require("../controllers/produk_controller")
const authentication = require("../middlewares/authentication")

router.get("/", ProdukController.allProduk)
// router.get("/best_sellers", ProdukController.bestSellers)
router.post("/", authentication, ProdukController.createProduk)
router.put("/", authentication, ProdukController.updateProduk)
router.delete("/:id", authentication, ProdukController.hapusProduk)

module.exports = router