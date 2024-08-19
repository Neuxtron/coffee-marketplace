const express = require("express")
const router = express.Router()
const authentication = require("../middlewares/authentication")
const OrderController = require("../controllers/order_controller")

router.post("/", authentication, OrderController.createOrder)
router.get("/", authentication, OrderController.riwayatOrder)
router.put("/status", authentication, OrderController.nextStatus)

module.exports = router