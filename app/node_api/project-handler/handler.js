const express = require('express')
const serverless = require('serverless-http')
const bodyParser = require('body-parser')
const AWS = require('aws-sdk')
const verification = require('./../verification')
const activityLogger = require('./../activity_logger')
const app = express()

const PROJECTS_TABLE = process.env.PROJECTS_TABLE
const dynamoDb = new AWS.DynamoDB.DocumentClient()
var projectCount = 0

app.use(bodyParser.json()) // to support JSON-encoded bodies
app.use(bodyParser.urlencoded({ extended: true })) // to support URL-encoded bodies

//endpoint function that returns all projects by various filters

app.get('/projects', (req, res) => {
    verification.isValidAdmin(req.headers.token)
        .then(isValid => {
            if (isValid) {
                var params = {
                    TableName: PROJECTS_TABLE
                }
                var userFiltered = false
                var clientFiltered = false
                //if filtered by  foreman id  eg  projects?foreman_id=1
                if (req.query.foreman_id !== undefined && !isNaN(req.query.foreman_id)) {
                    params.FilterExpression = "user_id = :user_id"
                    params.ExpressionAttributeValues = { ":user_id": parseInt(req.query.foreman_id) }
                    userFiltered = true
                }
                //if filtered by  client id also eg  projects?foreman_id=1&client_id=3 or projects?client_id=3 
                if (req.query.client_id !== undefined && !isNaN(req.query.client_id)) {
                    params.FilterExpression = userFiltered ? params.FilterExpression + " AND client_id = :client_id" : "client_id = :client_id"
                    if (userFiltered)
                        params.ExpressionAttributeValues[":client_id"] = parseInt(req.query.client_id)
                    else
                        params.ExpressionAttributeValues = { ":client_id": parseInt(req.query.client_id) }
                    clientFiltered = true
                }
                //if filtered by  completion status  also
                if (req.query.status !== undefined && req.query.status !== null) {
                    params.ExpressionAttributeNames = { "#status": "status" }
                    if (clientFiltered || userFiltered) {
                        params.FilterExpression = params.FilterExpression + " AND #status = :status"
                        params.ExpressionAttributeValues[":status"] = req.query.status
                    }
                    else {
                        params.FilterExpression = "#status = :status"
                        params.ExpressionAttributeValues = { ":status": req.query.status }
                    }
                }

                dynamoDb.scan(params, (error, result) => {
                    if (error)
                        res.status(error.statusCode || 503).json({ error: error.message })
                    else
                        res.status(200).json({ projects: result.Items })
                })
            }
            else {

                //if not admin, then must be filtered by  foreman id  eg  projects?foreman_id=1
                if (req.query.foreman_id !== undefined && !isNaN(req.query.foreman_id)) {
                    var params = {
                        TableName: PROJECTS_TABLE
                    }
                    params.FilterExpression = "user_id = :user_id"
                    params.ExpressionAttributeValues = { ":user_id": parseInt(req.query.foreman_id) }

                    //if filtered by  completion status  also
                    if (req.query.status !== undefined && req.query.status !== null) {
                        params.ExpressionAttributeNames = { "#status": "status" }
                        params.FilterExpression = params.FilterExpression + " AND #status = :status"
                        params.ExpressionAttributeValues[":status"] = req.query.status
                    }

                    dynamoDb.scan(params, (error, result) => {
                        if (error)
                            res.status(error.statusCode || 503).json({ error: error.message })
                        else
                            res.status(200).json({ projects: result.Items })
                    })
                }
                else
                    res.status(401).json({ error: "User not authorised to make this request." })
            }
        })
        .catch(error => { res.status(400).json({ error: error.message }) })
})

//endpoint function that returns a project by projectId
app.get('/projects/:projectId', (req, res) => {
    verification.isValidUser(req.headers.token)
        .then(isValid => {
            if (isValid) {
                if (!isNaN(req.params.projectId)) {
                    const params = {
                        TableName: PROJECTS_TABLE,
                        Key: {
                            projectId: parseInt(req.params.projectId)
                        }
                    }

                    dynamoDb.get(params, (error, result) => {
                        if (error)
                            res.status(error.statusCode || 503).json({ error: error.message })
                        else if (result.Item)
                            res.status(200).json({ project: result.Item })
                        else
                            res.status(404).response({ error: "Project with id " + req.params.projectId + " not found" })
                    })
                }
                else
                    res.status(400).json({ error: "Project id provided is not a number" })
            }
            else
                res.status(401).json({ error: "User not authorised to make this request." })
        })
        .catch(error => { res.status(400).json({ error: error.message }) })
})

//endpoint function that create a new Project
app.post('/projects', (req, res) => {
    verification.isValidAdmin(req.headers.token)
        .then(isValid => {
            if (isValid) {
                const project = req.body
                const floatRegex = /^\d+(\.\d{1,2})?$/
                if (project.client_id !== undefined && !isNaN(project.client_id) &&
                    project.user_id !== undefined && !isNaN(project.user_id) &&
                    project.name !== undefined && project.estimated_cost !== undefined && floatRegex.test(project.estimated_cost) &&
                    project.status !== undefined && project.expenditure !== undefined && floatRegex.test(project.expenditure) &&
                    project.team_size !== undefined && !isNaN(project.team_size) &&
                    project.start_date !== undefined && !isNaN(project.start_date) &&
                    project.end_date !== undefined && !isNaN(project.end_date)) {


                    const params = {
                        TableName: PROJECTS_TABLE,
                        Item: {
                            projectId: projectCount + 1,
                            client_id: parseInt(project.client_id),
                            user_id: parseInt(project.user_id),
                            name: project.name,
                            estimated_cost: parseFloat(project.estimated_cost),
                            expenditure: parseFloat(project.expenditure),
                            team_size: parseInt(project.team_size),
                            status: project.status,
                            start_date: parseInt(project.start_date),
                            end_date: parseInt(project.end_date)
                        }
                    }

                    dynamoDb.put(params, (error) => {
                        if (error)
                            res.status(error.statusCode || 503).json({ error: error.message })
                        else {
                            projectCount = projectCount + 1
                            activityLogger.logActivity(projectCount, activityLogger.activityType.CREATE_PROJECT, req.headers.token, projectCount)
                                .then(() => res.status(201).json({ message: "Project successfully created" }))
                                .catch(error => { res.status(201).json({ message: "Project successfully created", activity_error: error.message }) })
                        }
                    })
                }
                else {
                    const message = "Incomplete project details supplied or data is badly formatted"
                    res.status(400).json({ error: message })
                }
            }
            else
                res.status(401).json({ error: "User not authorised to make this request." })
        })
        .catch(error => { res.status(400).json({ error: error.message }) })
})


//endpoint function that updates  a project by projectId
app.put('/projects/:projectId', (req, res) => {
    verification.isValidUser(req.headers.token)
        .then(isValid => {
            if (isValid) {
                const project = req.body
                const floatRegex = /^\d+(\.\d{1,2})?$/
                if (!isNaN(req.params.projectId) &&
                    project.client_id !== undefined && !isNaN(project.client_id) &&
                    project.user_id !== undefined && !isNaN(project.user_id) &&
                    project.name !== undefined && project.estimated_cost !== undefined && floatRegex.test(project.estimated_cost) &&
                    project.status !== undefined && project.expenditure !== undefined && floatRegex.test(project.expenditure) &&
                    project.team_size !== undefined && !isNaN(project.team_size) &&
                    project.start_date !== undefined && !isNaN(project.start_date) &&
                    project.end_date !== undefined && !isNaN(project.end_date)) {

                    const params = {
                        TableName: PROJECTS_TABLE,
                        Key: { projectId: parseInt(req.params.projectId) },
                        ExpressionAttributeNames: { "#name": "name", "#status": "status" },
                        ExpressionAttributeValues: {
                            ":client_id": parseInt(project.client_id),
                            ":user_id": parseInt(project.user_id),
                            ":name": project.name,
                            ":estimated_cost": parseFloat(project.estimated_cost),
                            ":expenditure": parseFloat(project.expenditure),
                            ":team_size": parseInt(project.team_size),
                            ":status": project.status,
                            ":start_date": parseInt(project.start_date),
                            ":end_date": parseInt(project.end_date)
                        },
                        UpdateExpression: "SET #name = :name, client_id = :client_id, user_id = :user_id, #status = :status, estimated_cost = :estimated_cost, expenditure = :expenditure, team_size = :team_size, start_date = :start_date, end_date = :end_date"
                    }

                    dynamoDb.update(params, (error, result) => {
                        if (error)
                            res.status(error.statusCode || 503).json({ error: error.message })
                        else {
                            activityLogger.logActivity(parseInt(req.params.projectId), activityLogger.activityType.UPDATE_PROJECT, req.headers.token, parseInt(req.params.projectId))
                                .then(() => res.status(200).json({ message: "Project successfully updated" }))
                                .catch(error => { res.status(200).json({ message: "Project successfully updated", activity_error: error.message }) })
                        }
                    })
                }
                else {
                    const message = isNaN(req.params.projectId) ? "Project id " + req.params.projectId + " is not a number" : "Incomplete or incorrect project data supplied."
                    res.status(400).json({ error: message })
                }
            }
            else
                res.status(401).json({ error: "User not authorised to make this request." })
        })
        .catch(error => { res.status(400).json({ error: error.message }) })
})

//endpoint function that deletes a project by id
app.delete('/projects/:projectId', (req, res) => {
    verification.isValidAdmin(req.headers.token)
        .then(isValid => {
            if (isValid) {
                if (!isNaN(req.params.projectId)) {
                    const projectId = parseInt(req.params.projectId)
                    const params = {
                        TableName: PROJECTS_TABLE,
                        Key: { projectId: projectId }
                    }

                    dynamoDb.delete(params, (error, result) => {
                        if (error)
                            res.status(error.statusCode || 503).json({ error: error.message });
                        else {
                            activityLogger.logActivity(projectId, activityLogger.activityType.DELETE_PROJECT, req.headers.token, projectId)
                                .then(() => res.status(200).json({ message: "Project successfully deleted" }))
                                .catch(error => { res.status(200).json({ message: "Project successfully deleted", activity_error: error.message }) })
                        }
                    })
                }
                else
                    res.status(400).json({ error: "Project Id " + req.params.projectId + " is not a number" })
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
