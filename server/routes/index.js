const { Router } = require("express")
const router = Router()

const kategoriRouter = require("./kategori_route")

router.use("/kategori", kategoriRouter)

module.exports = router