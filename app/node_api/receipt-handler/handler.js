const express = require('express');
const serverless = require('serverless-http');
const bodyParser = require('body-parser');
const AWS = require('aws-sdk');
const app = express();

const RECEIPTS_TABLE = process.env.RECEIPTS_TABLE;
const dynamoDb = new AWS.DynamoDB.DocumentClient();
var receiptCount = 0;

app.use(bodyParser.json()); // to support JSON-encoded bodies
app.use(bodyParser.urlencoded({ extended: true })); // to support URL-encoded bodies

//need to redo the authorisation and create a notification for create, update and deletion of receipt

//endpoint function that returns all receipts


///Done: get all by projectID
///TODO: make sure it works correctly.

app.get('/receipts/:project_id', (req, res) => {
    verification.isValidUser(req.headers.token).then(isValid => {
        if (isValid) {
            if (isNaN(req.params.project_id) === false) {
                const params = {
                    TableName: RECEIPTS_TABLE,
                    FilterExpression: "project_id = :project_id",
                    ExpressionAttributeValues: {
                        ":project_id": req.params.project_id
                    }
                }

                // fetch all receipt from the database might change later due to pagination
                dynamoDb.scan(params, (error, result) => {
                    if (error) {
                        const errorStatusCode = error.statusCode || 503;
                        const response = {
                            error: error.message,
                        };
                        res.status(errorStatusCode).json(response);
                        return;
                    }
                    const response = {
                        receipt: result.Items,
                        message: "A list  of all receipts",
                    };
                    res.json(response);
                });
            }
            else
                res.status(404).json({ error: "Project ID " + req.params.project_id + " not found" })
        }
        else
            res.status(401).json({ error: "User not authorised to make this request." })
    }).catch(error => { res.status(400).json({ error: error.message }) })
});

//endpoint function that returns a receipt by receiptID
app.get('/receipts/:receiptId', (req, res) => {
    verification.isValidUser(req.headers.token).then(isValid => {
        if (isValid) {
            if (isNaN(req.params.receiptId) === false) {
                const params = {
                    TableName: RECEIPTS_TABLE,
                    Key: {
                        receiptId: parseInt(req.params.receiptId)
                    },
                };

                dynamoDb.get(params, (error, result) => {
                    if (error) {
                        const errorStatusCode = error.statusCode || 503;
                        const response = {
                            error: error.message,
                        };
                        res.status(errorStatusCode).json(response);
                        return;
                    }
                    if (result.Count > 0) {
                        const receipt = result.Item;
                        const responseStatusCode = 200;
                        const response = {
                            receipt: receipt,
                            message: "receipt retrieved successfully",
                        };
                        res.status(responseStatusCode).json(response);
                        return;
                    }
                });
            }
            const errorStatusCode = 404;
            const response = {
                error: "ReceiptId " + req.params.receiptId + " not found",
            };
            res.status(errorStatusCode).json(response);
        }
        else
            res.status(401).json({
                error: "User not authorised to make this request."
            })
    }).catch(error => { res.status(400).json({ error: error.message }) })
});

//endpoint function that create a new receipt
app.post('/receipts', (req, res) => {
    verification.isValidUser(req.headers.token).then(isValid => {
        if (isValid) {
            const receipt = req.body;
            if (receipt.project_id && receipt.supplier && receipt.description && receipt.total_cost && receipt.pic_url && receipt.purchase_date) {
                const params = {
                    TableName: RECEIPTS_TABLE,
                    Item: {
                        receiptId: receiptCount + 1,
                        project_id: receipt.project_id,
                        supplier: receipt.supplier,
                        description: receipt.description,
                        total_cost: receipt.total_cost,
                        pic_url: receipt.pic_url,
                        purchase_date: receipt.purchase_date,
                    },
                };

                dynamoDb.put(params, (error) => {
                    if (error) {
                        const errorStatusCode = error.statusCode || 503;
                        const response = {
                            error: error.message,
                        };
                        res.status(errorStatusCode).json(response);
                        return;
                    }
                    const responseStatusCode = 201;
                    const response = {
                        receipt: receipt,
                        message: "receipt successfully created",
                    };
                    receiptCount = receiptCount + 1;
                    res.status(responseStatusCode).json(response);
                });
            }
            else {
                const errorStatusCode = 400;
                const response = {
                    error: "Incomplete receipt supplied. Supply supplier_name, description of purchase, tota_cost, receipt_picture and purchase date",
                }
                res.status(errorStatusCode).json(response);
            }
        }
        else
            res.status(401).json({
                error: "User not authorised to make this request."
            })
    }).catch(error => { res.status(400).json({ error: error.message }) })
});

//endpoint function that updates  a receipt by receiptId
app.put('/receipt/:receiptId', (req, res) => {
    verification.isValidUser(req.headers.token).then(isValid => {
        if (isValid) {
            const receipt = req.body;
            if (isNaN(req.params.receiptId) === false && receipt.project_id && receipt.supplier && receipt.description && receipt.total_cost && receipt.pic_url && receipt.purchase_date) {
                const params = {
                    TableName: RECEIPTS_TABLE,
                    Key: {
                        receiptId: parseInt(req.params.receiptId),
                    },
                    ExpressionAttributeValues: {
                        ":project_id": receipt.project_id,
                        ":supplier": receipt.supplier,
                        ":description": receipt.description,
                        ":total_cost": receipt.total_cost,
                        ":pic_url": receipt.pic_url,
                        ":purchase_date": receipt.purchase_date,
                    },
                    UpdateExpression: "SET project_id = :project_id, supplier = :supplier, description = :description, total_cost = :total_cost, pic_url = :pic_url, purchase_date = :purchase_date",
                };

                dynamoDb.update(params, (error, result) => {
                    if (error) {
                        const errorStatusCode = error.statusCode || 503;
                        const response = {
                            error: error.message,
                        };
                        res.status(errorStatusCode).json(response);
                    }
                    if (result) {
                        const responseStatusCode = 200;
                        const response = {
                            message: "receipt updated successfully.",
                        };
                        res.status(responseStatusCode).json(response);
                    }
                });
            }
            else {
                const errorStatusCode = isNaN(req.params.receiptId) ? 404 : 400;
                const message = isNaN(req.params.receiptId) ? "Receipt " + req.params.receiptId + " not found" : "Incomplete receipt supplied.";
                const response = {
                    error: message,
                }
                res.status(errorStatusCode).json(response);
            }
        }
        else
            res.status(401).json({
                error: "User not authorised to make this request."
            })
    }).catch(error => { res.status(400).json({ error: error.message }) })
});

//endpoint function that deletes a receipt by id
app.delete('/receipts/:receiptId', (req, res) => {
    verification.isValidUser(req.headers.token).then(isValid => {
        if (isValid) {

            if (!isNaN(req.params.receiptId)) {
                const receiptId = parseInt(req.params.receiptId);
                const params = {
                    TableName: RECEIPTS_TABLE,
                    Key: {
                        receiptId: receiptId,
                    },
                }

                dynamoDb.delete(params, (error, result) => {
                    if (error) {
                        const errorStatusCode = error.statusCode || 503;
                        const response = {
                            error: error.message,
                        };
                        res.status(errorStatusCode).json(response);
                    }
                    if (result) {
                        const responseStatusCode = 200;
                        const response = {
                            receipt: result.Item,
                            message: "Receipt was successfully deleted",
                        };
                        res.status(responseStatusCode).json(response);
                    }
                });
            }
            else {
                const errorStatusCode = 404;
                const message = "receiptId " + req.params.receiptId + " not found";
                const response = {
                    error: message,
                }
                res.status(errorStatusCode).json(response);
            }
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