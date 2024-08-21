const express = require("express")
const authentication = require("../middlewares/authentication")
const AlamatController = require("../controllers/alamat_controller")
const router = express.Router()

router.post("/", authentication, AlamatController.tambahAlamat)
router.put("/", authentication, AlamatController.updateAlamat)
router.delete("/:id", authentication, AlamatController.hapusAlamat)

module.exports = router