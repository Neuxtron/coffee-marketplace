const express = require("express")
const cors = require("cors");
const routes = require("./routes/index")

const app = express()

app.use(express.json())
app.use(cors({ origin: "*" }))
app.use("/api", routes)
app.use("/images", express.static("./images/"))
app.use("/icons", express.static("./icons/"))

module.exports = app