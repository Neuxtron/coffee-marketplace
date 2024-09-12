const sequelize = require("../config/database")
const app = require("../app")
const PORT = 5000

sequelize.sync().then(() => {
  app.listen(PORT, () => {
    console.log(`Listening on port ${PORT}...`)
  })
})

module.exports = app
