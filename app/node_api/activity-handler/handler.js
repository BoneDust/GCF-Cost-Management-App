const express = require('express')
const serverless = require('serverless-http')
const bodyParser = require('body-parser')
const AWS = require('aws-sdk')
const verification = require('./../verification')
const app = express()

const ACTIVITIES_TABLE = process.env.ACTIVITIES_TABLE
const dynamoDb = new AWS.DynamoDB.DocumentClient()
var activityCount = 0

app.use(bodyParser.json()) // to support JSON-encoded bodies
app.use(bodyParser.urlencoded({ extended: true })) // to support URL-encoded bodies

//retrieve all activities
app.get('/activities', function (req, res) {

})

//retrieve activity by id
app.get('/activities/:id', function (req, res) {

})

//filtering activities by date
app.get('/activities/:date', function (req, res) {

})

//creating a notification
app.post('/activities', function (req, res) {

})


// Handle in-valid route
app.all('*', function (req, res) {
    const response = { error: 'Route not found!!' }
    res.status(400).send(response)
});

// wrap express app instance with serverless http function
module.exports.handler = serverless(app);