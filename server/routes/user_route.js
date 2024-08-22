const express = require("express")
const UserController = require("../controllers/user_controller")
const authentication = require("../middlewares/authentication")
const router = express.Router()

router.get("/profile", authentication, UserController.getProfile)
router.post("/register", UserController.registerUser)
router.post("/login", UserController.loginUser)
router.get("/logout", authentication, UserController.logoutUser)
router.get("/pakar", UserController.allPakar)
router.post("/request_ubah_password", UserController.requestUbahPassword)
router.post("/check_otp", UserController.checkOTP)
router.post("/ubah_password", UserController.ubahPasswordOTP)
router.put("/request_konfirmasi_email", authentication, UserController.requestKonfirmasiEmail)
router.put("/konfirmasi_email", authentication, UserController.konfirmasiEmail)

module.exports = router