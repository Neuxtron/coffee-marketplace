const express = require("express")
const BannerController = require("../controllers/banner_controller")
const router = express.Router()

router.get("/", BannerController.getBanners)

module.exports = router