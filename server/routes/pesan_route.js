const express = require("express")
const PesanController = require("../controllers/pesan_controller")
const router = express.Router()

router.get("/", PesanController.allPesan)
router.post("/send", PesanController.createPesan)
router.put("/read", PesanController.readPesan)
router.delete("/delete", PesanController.deletePesan)

module.exports = router