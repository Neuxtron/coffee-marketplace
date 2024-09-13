const sequelize = require("../config/database")
const app = require("../app")
const PORT = 5000

app.get("/", (req, res) => {
  const midtransClientKey = process.env.MIDTRANS_CLIENT_KEY
  console.info(`Midtrans Client Key: ${midtransClientKey}`)
  return res.status(200).json({})
})

sequelize.sync().then(() => {
  app.listen(PORT, () => {
    console.log(`Listening on port ${PORT}...`)
  })
})

module.exports = app
