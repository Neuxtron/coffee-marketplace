const { Router } = require("express")
const router = Router()

const kategoriRouter = require("./kategori_route")
const produkRoute = require("./produk_route")
const userRoute = require("./user_route")

router.use("/kategori", kategoriRouter)
router.use("/produk", produkRoute)
router.use("/", userRoute)

module.exports = router