const express = require('express')
const serverless = require('serverless-http')
const bodyParser = require('body-parser')
const AWS = require('aws-sdk')
const verification = require('./../verification')
const activityLogger = require('./../activity_logger')
const app = express()

const CLIENTS_TABLE = process.env.CLIENTS_TABLE
const dynamoDb = new AWS.DynamoDB.DocumentClient()
var clientCount = 0

app.use(bodyParser.json()) // to support JSON-encoded bodies
app.use(bodyParser.urlencoded({ extended: true })) // to support URL-encoded bodies

//endpoint function that returns all clients
app.get('/clients', (req, res) => {
  verification.isValidAdmin(req.headers.token)
    .then(isValid => {
      if (isValid) {

        const params = {
          TableName: CLIENTS_TABLE
        }

        dynamoDb.scan(params, (error, result) => {
          if (error)
            res.status(error.statusCode || 503).json({ error: error.message })
          else
            res.status(200).json({ clients: result.Items })
        })
      }
      else
        res.status(401).json({ error: "User not authorised to make this request." })
    })
    .catch(error => { res.status(400).json({ error: error.message }) })
})

//endpoint function that returns a client by clientID
app.get('/clients/:client_id', (req, res) => {
  verification.isValidAdmin(req.headers.token)
    .then(isValid => {
      if (isValid) {
        if (isNaN(req.params.client_id) === false) {
          const params = {
            TableName: CLIENTS_TABLE,
            Key: { clientId: parseInt(req.params.client_id) }
          }

          dynamoDb.get(params, (error, result) => {
            if (error)
              res.status(error.statusCode || 503).json({ error: error.message })
            else if (result.Item)
              res.status(200).json({ client: result.Item })
            else
              res.status(404).json({ error: "Client with id " + req.params.client_id + " not found" })
          })
        }
        else
          res.status(400).json({ error: "Client id provided is not a number" })
      }
      else
        res.status(401).json({ error: "User not authorised to make this request." })
    })
    .catch(error => { res.status(400).json({ error: error.message }) })
})

//endpoint function that create a new client
app.post('/clients', (req, res) => {
  verification.isValidAdmin(req.headers.token)
    .then(isValid => {
      if (isValid) {
        const client = req.body
        if (client.name && client.contact_person && client.contact_number) {
          const params = {
            TableName: CLIENTS_TABLE,
            Item: {
              clientId: clientCount + 1,
              name: client.name,
              contact_person: client.contact_person,
              contact_number: client.contact_number
            }
          }

          dynamoDb.put(params, (error, result) => {
            if (error)
              res.status(error.statusCode || 503).json({ error: error.message })
            else {
              clientCount = clientCount + 1
              activityLogger.logActivity(0, activityLogger.activityType.CREATE_CLIENT, req.headers.token, clientCount)
                .then(() => res.status(201).json({ message: "Client successfully created" }))
                .catch(error => { res.status(201).json({ message: "Client successfully created", activity_error: error.message }) })
            }
          })
        }
        else {
          const message = "Incomplete client data supplied. Supply client name, contact person and number"
          res.status(400).json({ error: message })
        }
      }
      else
        res.status(401).json({ error: "User not authorised to make this request." })
    })
    .catch(error => { res.status(400).json({ error: error.message }) })
})

//endpoint function that updates  a client by clientId
app.put('/clients/:client_id', (req, res) => {
  verification.isValidAdmin(req.headers.token)
    .then(isValid => {
      if (isValid) {
        const client = req.body;
        if (!isNaN(req.params.client_id) && client.name && client.contact_person && client.contact_number) {
          const params = {
            TableName: CLIENTS_TABLE,
            Key: { clientId: parseInt(req.params.client_id) },
            ExpressionAttributeNames: { "#name": "name" },
            ExpressionAttributeValues: {
              ":name": client.name,
              ":person": client.contact_person,
              ":number": client.contact_number
            },
            UpdateExpression: "SET #name = :name, contact_person = :person, contact_number = :number"
          }

          dynamoDb.update(params, (error, result) => {
            if (error)
              res.status(error.statusCode || 503).json({ error: error.message });
            else {
              activityLogger.logActivity(0, activityLogger.activityType.UPDATE_CLIENT, req.headers.token, parseInt(req.params.client_id))
                .then(() => res.status(200).json({ message: "Client successfully updated" }))
                .catch(error => { res.status(200).json({ message: "Client successfully updated", activity_error: error.message }) })
            }
          })
        }
        else {

          const message = isNaN(req.params.client_id) ? "Client  " + req.params.client_id + " is not a number" : "Incomplete client data  supplied."
          res.status(400).json({ error: message })
        }
      }
      else
        res.status(401).json({ error: "User not authorised to make this request." })
    })
    .catch(error => { res.status(400).json({ error: error.message }) })
})

//endpoint function that deletes a client by id
app.delete('/clients/:client_id', (req, res) => {
  verification.isValidAdmin(req.headers.token).then(isValid => {
    if (isValid) {
      if (!isNaN(req.params.client_id)) {
        const params = {
          TableName: CLIENTS_TABLE,
          Key: { clientId: parseInt(req.params.client_id) }
        }

        dynamoDb.delete(params, (error, result) => {
          if (error)
            res.status(error.statusCode || 503).json({ error: error.message });
          else {
            activityLogger.logActivity(0, activityLogger.activityType.DELETE_CLIENT, req.headers.token, parseInt(req.params.client_id))
              .then(() => res.status(200).json({ message: "Client successfully deleted" }))
              .catch(error => { res.status(200).json({ message: "Client successfully deleted", activity_error: error.message }) })
          }
        })
      }
      else
        res.status(400).json({ error: "Client id " + req.params.client_id + " is not a number" })
    }
    else
      res.status(401).json({
        error: "User not authorised to make this request."
      })
  }).catch(error => { res.status(400).json({ error: error.message }) })
});
///

// Handle in-valid route
app.all('*', function (req, res) {
  const response = { data: null, message: 'Route not found!!' }
  res.status(400).send(response)
});

// wrap express app instance with serverless http function
module.exports.handler = serverless(app);