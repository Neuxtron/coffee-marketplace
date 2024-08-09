const express = require("express")
const GambarProdukController = require("../controllers/gambar_produk_controller")
const authentication = require("../middlewares/authentication")
const uploadGambar = require("../middlewares/upload_gambar")
const router = express.Router()

router.post("/", authentication, uploadGambar, GambarProdukController.uploadGambarProduk)
router.put("/", authentication, uploadGambar, GambarProdukController.updateGambarProduk)

module.exports = router