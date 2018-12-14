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

//filtering activities by date



//retrieve all activities
app.get('/activities', function (req, res) {
    verification.isValidAdmin(req.headers.token)
        .then(isValid => {
            if (isValid) {
                const params = {
                    TableName: ACTIVITIES_TABLE
                }

                dynamoDb.scan(params, (error, result) => {
                    if (error)
                        res.status(error.statusCode || 503).json({ error: error.message })
                    else
                        res.status(200).json({ activities: result.Items })
                })

            }
            else
                res.status(401).json({ error: "User not authorised to make this request." })
        })
        .catch(error => { res.status(400).json({ error: error.message }) })

})

//retrieve activity by id
app.get('/activities/:id', function (req, res) {

    verification.isValidUser(req.headers.token)
        .then(isValid => {
            if (isNaN(req.params.id) === false) {
                const params = {
                    TableName: ACTIVITIES_TABLE,
                    Key: {
                        activityId: parseInt(req.params.id)
                    }
                }

                dynamoDb.get(params, (error, result) => {
                    if (error)
                        res.status(error.statusCode || 503).json({ error: error.message })
                    else if (result.Item)
                        res.status(200).json({ activity: result.Item })
                    else
                        res.status(404).json({ error: "Activity id " + req.params.userId + " not found" })
                })
            }
            else
                res.status(400).json({ error: "Activity id provided provided is not a number" })
        })
        .catch(error => { res.status(400).json({ error: error.message }) })

})

//retrieve activity by projectId
app.get('/activities/activitiesByProject/:project_id', function (req, res) {

    verification.isValidUser(req.headers.token)
        .then(isValid => {
            if (isNaN(req.params.project_id) === false) {
                const params = {
                    TableName: ACTIVITIES_TABLE,
                    FilterExpression: "project_id = :project_id",
                    ExpressionAttributeValues: {
                        ":project_id": req.params.project_id
                    }
                }

                dynamoDb.scan(params, (error, result) => {
                    if (error)
                        res.status(error.statusCode || 503).json({ error: error.message })
                    else if (result.Item)
                        res.status(200).json({ activities: result.Items })
                    else
                        res.status(404).json({ error: "Project " + req.params.project_id + " not found" })
                })
            }
            else
                res.status(400).json({ error: "Project id provided provided is not a number" })
        })
        .catch(error => { res.status(400).json({ error: error.message }) })

})


//creating an activity
app.post('/activities', function (req, res) {
    verification.isValidUser(req.headers.token).then(isValid => {
        if (isValid) {
            const activity = req.body;
            if (activity.project_id && activity.title && activity.description) {
                const params = {
                    TableName: ACTIVITIES_TABLE,
                    Item: {
                        activityId: activityCount + 1,
                        project_id: activity.project_id,
                        title: activity.title,
                        description: activity.description,
                        creation_date: new Date().toISOString().replace('T', ' ').substr(0, 19)
                    }
                }

                dynamoDb.put(params, (error) => {
                    if (error)
                        res.status(error.statusCode || 503).json({ error: error.message });
                    else {
                        activityCount = activityCount + 1
                        res.status(201).json({ message: "activity successfully created" })
                    }
                });
            }
            else
                res.status(400).json({ error: "Incomplete activity supplied. Supply supplier_name, description of purchase, tota_cost, activity_picture and purchase date", });
        }
        else
            res.status(401).json({ error: "User not authorised to make this request." })
    }).catch(error => { res.status(400).json({ error: error.message }) })
})


// Handle in-valid route
app.all('*', function (req, res) {
    const response = { error: 'Route not found!!' }
    res.status(400).send(response)
});

// wrap express app instance with serverless http function
module.exports.handler = serverless(app);