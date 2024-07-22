const express = require("express")
const router = express.Router()
const KeranjangController = require("../controllers/keranjang_controller")
const authentication = require("../middlewares/authentication")

router.get("/", authentication, KeranjangController.keranjangRiwayatByUser)
router.put("/", authentication, KeranjangController.updateKeranjang)

module.exports = router