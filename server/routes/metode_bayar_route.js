const express = require("express")
const MetodeBayarController = require("../controllers/metode_bayar_controller")
const router = express.Router()

router.get("/", MetodeBayarController.allMetode)

module.exports = router