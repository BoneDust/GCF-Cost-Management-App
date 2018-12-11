const serverless = require('serverless-http');
const express = require('express')
const bodyParser = require('body-parser')
const app = express()

app.get('/', function (req, res) {
    res.send('Hello World!')
})

module.exports.handler = serverless(app);