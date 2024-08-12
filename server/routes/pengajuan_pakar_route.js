const express = require("express")
const PengajuanPakarController = require("../controllers/pengajuan_pakar_controller")
const authentication = require("../middlewares/authentication")
const router = express.Router()

router.get("/", authentication, PengajuanPakarController.allPengajuan)
router.post("/", authentication, PengajuanPakarController.createPengajuan)
router.put("/approve/:id", authentication, PengajuanPakarController.approvePengajuan)

module.exports = router