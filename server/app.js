const express = require("express")
const cors = require("cors");
const sequelize = require("./config/database")
const routes = require("./routes/index")

const app = express()
const PORT = 3000

app.use(express.json())
app.use(cors({ origin: "*" }))
app.use(routes)
app.use("/images", express.static("./images/"))

sequelize.sync({ alter: true }).then(() => {
  app.listen(PORT, () => {
    console.log(`Listening on port ${PORT}...`)
  })
})
