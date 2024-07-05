const express = require("express")
const router = express.Router()
const KategoriController = require("../controllers/kategori_controller")

router.get("/", KategoriController.allKategori)

module.exports = router