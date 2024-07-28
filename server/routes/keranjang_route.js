const express = require("express")
const router = express.Router()
const KeranjangController = require("../controllers/keranjang_controller")
const authentication = require("../middlewares/authentication")

router.get("/", authentication, KeranjangController.keranjangByUser)
router.put("/", authentication, KeranjangController.updateKeranjang)
router.delete("/:id", authentication, KeranjangController.hapusKeranjang)

module.exports = router