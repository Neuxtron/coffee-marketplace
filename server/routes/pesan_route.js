const express = require("express")
const PesanController = require("../controllers/pesan_controller")
const authentication = require("../middlewares/authentication")
const router = express.Router()

router.get("/", authentication, PesanController.allPesan)
router.put("/new_messages", authentication, PesanController.getNewMessages)
router.get("/chatrooms", authentication, PesanController.chatRooms)
router.post("/send", authentication, PesanController.createPesan)
router.put("/read", authentication, PesanController.readPesan)
router.delete("/delete", authentication, PesanController.deletePesan)

module.exports = router