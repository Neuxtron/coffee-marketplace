const { Sequelize } = require("sequelize");

const db = new Sequelize('coffee-marketplace', 'root', '', {
    host: 'localhost',
    dialect: 'mysql',
    // TODO: custom logging
    logging: false,
})

module.exports = db;