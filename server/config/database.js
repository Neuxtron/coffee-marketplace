const { Sequelize } = require("sequelize");

const db = new Sequelize('miti8616_coffee-marketplace', 'miti8616_coffee-marketplace', 'coffee-marketplace', {
    host: 'miticommunity.com',
    dialect: 'mysql',
    // TODO: custom logging
    logging: false,
    dialectModule: require("mysql2"),
    pool: {
        max: 100,
        min: 0,
        idle: 100 * 1000,
        acquire: 100 * 1000,
    }
})

module.exports = db;