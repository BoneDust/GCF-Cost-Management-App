const express = require('express')
const serverless = require('serverless-http')
const bodyParser = require('body-parser')
const AWS = require('aws-sdk')
const verification = require('./../verification')
const app = express()

const NOTIFICATIONS_TABLE = process.env.NOTIFICATIONS_TABLE
const dynamoDb = new AWS.DynamoDB.DocumentClient()
var notificationCount = 0

app.use(bodyParser.json()) // to support JSON-encoded bodies
app.use(bodyParser.urlencoded({ extended: true })) // to support URL-encoded bodies

//retrieve all notifications
app.get('/notfications', function (req, res) {
    res.send('Hello World!')
})

//filtering notifications by id
app.get('/notifications/:id', function (req, res) {

})

//filtering notifications by title
app.get('/notificaton/:title', function (req, res) {

})

//creating a notification
app.post('/notifications', function (req, res) {

})


// Handle in-valid route
app.all('*', function (req, res) {
    const response = { error: 'Route not found!!' }
    res.status(400).send(response)
});

// wrap express app instance with serverless http function
module.exports.handler = serverless(app);