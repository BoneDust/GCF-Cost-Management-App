const express = require('express');
const serverless = require('serverless-http');
const bodyParser = require('body-parser');
const AWS = require('aws-sdk');
const verification = require('./../verification')
const app = express();

const STAGES_TABLE = process.env.STAGES_TABLE;
const dynamoDb = new AWS.DynamoDB.DocumentClient();
var stageCount = 0;

app.use(bodyParser.json()); // to support JSON-encoded bodies
app.use(bodyParser.urlencoded({ extended: true })); // to support URL-encoded bodies

//endpoint function that returns all stages


///Done: get all by projectID
///TODO: make sure it works correctly.

app.get('/stages/stagesByProject/:project_id', (req, res) => {
    verification.isValidUser(req.headers.token)
        .then(isValid => {
            if (isValid) {
                if (isNaN(req.params.project_id) === false) {
                    const params = {
                        TableName: STAGES_TABLE,
                        FilterExpression: "project_id = :project_id",
                        ExpressionAttributeValues: {
                            ":project_id": parseInt(req.params.project_id)
                        }
                    }

                    // fetch all stages from the database might change later due to pagination
                    dynamoDb.scan(params, (error, result) => {
                        if (error)
                            res.status(error.statusCode || 503).json({ error: error.message })
                        else
                            res.status(200).json({ stages: result.Items })
                    })
                }
                else
                    res.status(404).json({ error: "Project ID " + req.params.project_id + " not found" })
            }
            else
                res.status(401).json({ error: "User not authorised to make this request." })
        })
        .catch(error => { res.status(400).json({ error: error.message }) })
});

//endpoint function that returns a stage by stageID
app.get('/stages/:stageId', (req, res) => {
    verification.isValidUser(req.headers.token)
        .then(isValid => {
            if (isValid) {
                if (isNaN(req.params.stageId) === false) {
                    const params = {
                        TableName: STAGES_TABLE,
                        Key: {
                            stageId: parseInt(req.params.stageId)
                        }
                    }

                    dynamoDb.get(params, (error, result) => {
                        if (error)
                            res.status(error.statusCode || 503).json({ error: error.message });
                        else if (result.Item)
                            res.status(200).json({ stage: result.Item });
                        else
                            res.status(404).response({ error: "Stage id " + req.params.userId + " not found" })
                    });
                }
                else
                    res.status(400).json({ error: "Stage id provided provided is not a number" })
            }
            else
                res.status(401).json({ error: "User not authorised to make this request." })
        })
        .catch(error => { res.status(400).json({ error: error.message }) })
});

///TODO: trigger notifications for post, put and delete

//endpoint function that create a new stage
app.post('/stages', (req, res) => {
    verification.isValidUser(req.headers.token)
        .then(isValid => {
            if (isValid) {
                const stage = req.body
                if (stage.project_id && stage.stage_name && stage.description && stage.status && stage.before_pic_url && stage.start_date && stage.estimated_duration) {
                    const params = {
                        TableName: STAGES_TABLE,
                        Item: {
                            stageId: stageCount + 1,
                            project_id: stage.project_id,
                            stage_name: stage.stage_name,
                            description: stage.description,
                            status: stage.status,
                            before_pic_url: stage.before_pic_url,
                            start_date: stage.start_date,
                            estimated_duration: stage.estimated_duration
                        }
                    }

                    dynamoDb.put(params, (error) => {
                        if (error)
                            res.status(error.statusCode || 503).json({ error: error.message })
                        else {
                            stageCount = stageCount + 1
                            res.status(201).json({ message: "Stage successfully created" })
                        }
                    })
                }
                else
                    res.status(400).json({ error: "Incomplete stage supplied. Supply project_id, stage_name, descriptiom, status,  before_pic_url, start_date and estimated_duration" })
            }
            else
                res.status(401).json({ error: "User not authorised to make this request." })
        })
        .catch(error => { res.status(400).json({ error: error.message }) })
})


//endpoint function that updates  a stage by stageId
app.put('/stages/:stageId', (req, res) => {
    verification.isValidUser(req.headers.token)
        .then(isValid => {
            if (isValid) {
                const stage = req.body;
                if (isNaN(req.params.stageId) === false && stage.project_id && stage.stage_name && stage.description && stage.status && stage.before_pic_url && stage.after_pic_url && stage.start_date && stage.end_date && stage.estimated_duration) {
                    const params = {
                        TableName: STAGES_TABLE,
                        Key: {
                            stageId: parseInt(req.params.stageId),
                        },
                        ExpressionAttributeValues: {
                            ":project_id": stage.project_id,
                            ":stage_name": stage.stage_name,
                            ":description": stage.description,
                            ":status": stage.status,
                            ":before_pic_url": stage.before_pic_url,
                            ":after_pic_url": stage.after_pic_url,
                            ":start_date": stage.start_date,
                            ":end_date": stage.end_date,
                            ":estimated_duration": stage.estimated_duration
                        },
                        UpdateExpression: "SET project_id = :project_id, stage_name = :stage_name, description = :description, status = :status, before_pic_url = :before_pic_url, after_pic_url = :after_pic_url, start_date = :start_date, end_date = :end_date, estimated_duration = :estimated_duration"
                    }

                    dynamoDb.update(params, (error, result) => {
                        if (error)
                            res.status(error.statusCode || 503).json({ error: error.message });
                        else
                            res.status(200).json({ message: "Stage updated successfully." })
                    })
                }
                else {
                    const message = isNaN(req.params.stageId) ? "StageId " + req.params.stageId + " is not a number" : "Incomplete stage supplied."
                    const response = { error: message }
                    res.status(400).json(response);
                }
            }
            else
                res.status(401).json({ error: "User not authorised to make this request." })
        })
        .catch(error => { res.status(400).json({ error: error.message }) })
});

//endpoint function that deletes a stage by id
app.delete('/stages/:stageId', (req, res) => {
    verification.isValidUser(req.headers.token)
        .then(isValid => {
            if (isValid) {

                if (!isNaN(req.params.stageId)) {
                    const stageId = parseInt(req.params.stageId)
                    const params = {
                        TableName: STAGES_TABLE,
                        Key: {
                            stageId: stageId
                        }
                    }

                    dynamoDb.delete(params, (error, result) => {
                        if (error)
                            res.status(error.statusCode || 503).json({ error: error.message });
                        else
                            res.status(200).json({ message: "Stage successfully deleted" });
                    })
                }
                else
                    res.status(400).json({ error: "StageId " + req.params.stageId + " is not a number" });
            }
            else
                res.status(401).json({ error: "User not authorised to make this request." })
        })
        .catch(error => { res.status(400).json({ error: error.message }) })
})

// Handle in-valid route
app.all('*', function (req, res) {
    const response = { data: null, message: 'Route not found!!' }
    res.status(400).send(response)
})

// wrap express app instance with serverless http function
module.exports.handler = serverless(app)
