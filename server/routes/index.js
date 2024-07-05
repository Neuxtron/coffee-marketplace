const { Router } = require("express")
const router = Router()

const kategoriRouter = require("./kategori_route")
const produkController = require("./produk_route")

router.use("/kategori", kategoriRouter)
router.use("/produk", produkController)

module.exports = router