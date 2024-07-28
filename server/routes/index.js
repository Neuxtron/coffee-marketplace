const { Router } = require("express")
const router = Router()

const kategoriRouter = require("./kategori_route")
const produkRoute = require("./produk_route")
const userRoute = require("./user_route")
const keranjangRoute = require("./keranjang_route")
const orderRoute = require("./order_route")

router.use("/kategori", kategoriRouter)
router.use("/produk", produkRoute)
router.use("/", userRoute)
router.use("/keranjang", keranjangRoute)
router.use("/order", orderRoute)

module.exports = router