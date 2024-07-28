const express = require("express")
const router = express.Router()
const authentication = require("../middlewares/authentication")
const OrderController = require("../controllers/order_controller")

router.post("/", authentication, OrderController.createOrder)

module.exports = router