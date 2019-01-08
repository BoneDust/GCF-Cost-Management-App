const express = require('express')
const serverless = require('serverless-http')
const bodyParser = require('body-parser')
const AWS = require('aws-sdk')
const verification = require('./../verification')
const activityLogger = require('./../activity_logger')
const app = express()

const RECEIPTS_TABLE = process.env.RECEIPTS_TABLE
const dynamoDb = new AWS.DynamoDB.DocumentClient()
var receiptCount = 0

app.use(bodyParser.json()) // to support JSON-encoded bodies
app.use(bodyParser.urlencoded({ extended: true })) // to support URL-encoded bodies

//endpoint function that returns all receipts by projectID
app.get('/receipts/receiptsByProject/:project_id', (req, res) => {
    verification.isValidUser(req.headers.token)
        .then(isValid => {
            if (isValid) {
                if (!isNaN(req.params.project_id)) {
                    const params = {
                        TableName: RECEIPTS_TABLE,
                        FilterExpression: "project_id = :project_id",
                        ExpressionAttributeValues: {
                            ":project_id": parseInt(req.params.project_id)
                        }
                    }

                    dynamoDb.scan(params, (error, result) => {
                        if (error)
                            res.status(error.statusCode || 503).json({ error: error.message })
                        else
                            res.status(200).json({ receipts: result.Items })
                    })
                }
                else
                    res.status(400).json({ error: "Project id provided provided is not a number" })
            }
            else
                res.status(401).json({ error: "User not authorised to make this request." })
        })
        .catch(error => { res.status(400).json({ error: error.message }) })
})

//endpoint function that returns a receipt by receiptID
app.get('/receipts/:receiptId', (req, res) => {
    verification.isValidUser(req.headers.token)
        .then(isValid => {
            if (isValid) {
                if (isNaN(req.params.receiptId) === false) {
                    const params = {
                        TableName: RECEIPTS_TABLE,
                        Key: {
                            receiptId: parseInt(req.params.receiptId)
                        }
                    }

                    dynamoDb.get(params, (error, result) => {

                        if (error)
                            res.status(error.statusCode || 503).json({ error: error.message })
                        else if (result.Item)
                            res.status(200).json({ receipt: result.Item })
                        else
                            res.status(404).json({ error: "Receipt with id " + req.params.receiptId + " not found" })
                    })
                }
                else
                    res.status(400).json({ error: "Receipt id provided is not a number" })
            }
            else
                res.status(401).json({ error: "User not authorised to make this request." })
        })
        .catch(error => { res.status(400).json({ error: error.message }) })
})

//endpoint function that create a new receipt
app.post('/receipts', (req, res) => {
    verification.isValidUser(req.headers.token)
        .then(isValid => {
            if (isValid) {
                const receipt = req.body
                if (receipt.project_id !== undefined && !isNaN(receipt.project_id) &&
                    receipt.supplier !== undefined && receipt.description !== undefined &&
                    receipt.total_cost !== undefined && receipt.pic_url !== undefined &&
                    receipt.purchase_date !== undefined && !isNaN(receipt.purchase_date)) {

                    const params = {
                        TableName: RECEIPTS_TABLE,
                        Item: {
                            receiptId: receiptCount + 1,
                            project_id: parseInt(receipt.project_id),
                            supplier: receipt.supplier,
                            description: receipt.description,
                            total_cost: receipt.total_cost,
                            pic_url: receipt.pic_url,
                            purchase_date: parseInt(receipt.purchase_date)
                        }
                    }

                    dynamoDb.put(params, (error, result) => {
                        if (error)
                            res.status(error.statusCode || 503).json({ error: error.message })
                        else {
                            receiptCount = receiptCount + 1
                            activityLogger.logActivity(parseInt(receipt.project_id), activityLogger.activityType.CREATE_RECEIPT, req.headers.token, receiptCount)
                                .then(() => res.status(201).json({ message: "Receipt successfully created" }))
                                .catch(error => { res.status(201).json({ message: "Receipt successfully created", activity_error: error.message }) })
                        }
                    })
                }
                else {
                    const message = isNaN(receipt.project_id) ? "project_id " + receipt.project_id + " is not a number" : "Incomplete receipt supplied. Supply supplier, description of purchase, total_cost, receipt_picture and purchase date"
                    res.status(400).json({ error: message })
                }
            }
            else
                res.status(401).json({ error: "User not authorised to make this request." })
        })
        .catch(error => { res.status(400).json({ error: error.message }) })
})

//endpoint function that updates  a receipt by receiptId
app.put('/receipts/:receiptId', (req, res) => {
    verification.isValidUser(req.headers.token)
        .then(isValid => {
            if (isValid) {
                const receipt = req.body;
                if (!isNaN(req.params.receiptId) && receipt.project_id !== undefined && !isNaN(receipt.project_id) &&
                    receipt.supplier !== undefined && receipt.description !== undefined &&
                    receipt.total_cost !== undefined && receipt.pic_url !== undefined &&
                    receipt.purchase_date !== undefined && !isNaN(receipt.purchase_date)) {
                    const params = {
                        TableName: RECEIPTS_TABLE,
                        Key: {
                            receiptId: parseInt(req.params.receiptId)
                        },
                        ExpressionAttributeValues: {
                            ":project_id": parseInt(receipt.project_id),
                            ":supplier": receipt.supplier,
                            ":description": receipt.description,
                            ":total_cost": receipt.total_cost,
                            ":pic_url": receipt.pic_url,
                            ":purchase_date": parseInt(receipt.purchase_date)
                        },
                        UpdateExpression: "SET project_id = :project_id, supplier = :supplier, description = :description, total_cost = :total_cost, pic_url = :pic_url, purchase_date = :purchase_date"
                    }

                    dynamoDb.update(params, (error, result) => {
                        if (error)
                            res.status(error.statusCode || 503).json({ error: error.message });
                        else {
                            activityLogger.logActivity(parseInt(receipt.project_id), activityLogger.activityType.UPDATE_RECEIPT, req.headers.token, parseInt(req.params.receiptId))
                                .then(() => res.status(200).json({ message: "Receipt successfully updated" }))
                                .catch(error => { res.status(200).json({ message: "Receipt successfully updated", activity_error: error.message }) })
                        }
                    })
                }
                else {

                    const message = isNaN(req.params.receiptId) ? "receiptId " + req.params.receiptId + " is not a number" : "Incomplete receipt supplied."
                    res.status(400).json({ error: message })
                }
            }
            else
                res.status(401).json({ error: "User not authorised to make this request." })
        })
        .catch(error => { res.status(400).json({ error: error.message }) })
})

//endpoint function that deletes a receipt by id
app.delete('/receipts/:receiptId', (req, res) => {
    verification.isValidUser(req.headers.token).then(isValid => {
        if (isValid) {

            if (!isNaN(req.params.receiptId)) {
                const params = {
                    TableName: RECEIPTS_TABLE,
                    Key: {
                        receiptId: parseInt(req.params.receiptId)
                    },
                    ReturnValues: 'ALL_OLD'
                }

                dynamoDb.delete(params, (error, result) => {
                    if (error)
                        res.status(error.statusCode || 503).json({ error: error.message });
                    else {
                        activityLogger.logActivity(parseInt(result.Attributes.project_id), activityLogger.activityType.DELETE_RECEIPT, req.headers.token, parseInt(req.params.receiptId))
                            .then(() => res.status(200).json({ message: "Receipt successfully deleted" }))
                            .catch(error => { res.status(200).json({ message: "Receipt successfully deleted", activity_error: error.message }) })
                    }
                })
            }
            else
                res.status(400).json({ error: "receiptId " + req.params.receiptId + " is not a number" })
        }
        else
            res.status(401).json({
                error: "User not authorised to make this request."
            })
    }).catch(error => { res.status(400).json({ error: error.message }) })
})


// Handle in-valid route
app.all('*', function (req, res) {
    const response = { data: null, message: 'Route not found!!' }
    res.status(400).send(response)
})

// wrap express app instance with serverless http function
module.exports.handler = serverless(app);