const express = require("express")
const PengajuanPakarController = require("../controllers/pengajuan_pakar_controller")
const authentication = require("../middlewares/authentication")
const router = express.Router()

router.get("/", authentication, PengajuanPakarController.allPengajuan)

module.exports = router