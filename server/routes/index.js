const { Router } = require("express")
const router = Router()

const kategoriRouter = require("./kategori_route")
const produkRoute = require("./produk_route")
const userRoute = require("./user_route")
const keranjangRoute = require("./keranjang_route")
const orderRoute = require("./order_route")
const metodeBayarRoute = require("./metode_bayar_route")

router.use("/kategori", kategoriRouter)
router.use("/produk", produkRoute)
router.use("/", userRoute)
router.use("/keranjang", keranjangRoute)
router.use("/order", orderRoute)
router.use("/metode_bayar", metodeBayarRoute)

module.exports = router