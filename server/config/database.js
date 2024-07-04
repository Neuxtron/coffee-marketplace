const { Sequelize } = require("sequelize");

const db = new Sequelize('coffee-marketplace', 'root', '', {
    host: 'localhost',
    dialect: 'mysql'
})

module.exports = db;