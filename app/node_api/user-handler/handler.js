const express = require('express')
const serverless = require('serverless-http')
const bodyParser = require('body-parser')
const aws = require('aws-sdk')

const app = express()

app.use(bodyParser.json())//i dont know what this does
app.use(bodyParser.urlencoded({ extended: true }))// this too i dont know

//endpoint function that returns all users
app.get('/users', (req, res) => {
   
})

//endpoint function that returns a user by id
app.get('/users/:id', (req, res) => {
   
})

//endpoint function thats logs in a user and sends that user a unique api key/ or priviledge key
app.post('/users/login', (req, res) => {
   
})

//endpoint function that create a new user
app.post('/users', (req, res) => {
   
})

//endpoint function that updatesa user by id
app.put('/users/:id', (req, res) => {
   
})
//endpoint function thats returns all users
app.delete('/users/:id', (req, res) => {
   
})



// Handle in-valid route
app.all('*', function(req, res) {
  const response = { data: null, message: 'Route not found!!' }
  res.status(400).send(response)
})

// wrap express app instance with serverless http function
module.exports.handler = serverless(app)
