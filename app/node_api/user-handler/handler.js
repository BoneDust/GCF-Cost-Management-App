const express = require('express')
const serverless = require('serverless-http')
const bodyParser = require('body-parser')
const uuid = require('uuid')//will be used to create the jwt token
const AWS = require('aws-sdk')
const verification = require('./../verification')
const app = express()

const USERS_TABLE = process.env.USERS_TABLE
const dynamoDb = new AWS.DynamoDB.DocumentClient()
var userCount = 0

app.use(bodyParser.json()) // to support JSON-encoded bodies
app.use(bodyParser.urlencoded({ extended: true })) // to support URL-encoded bodies

//endpoint function that returns all users
app.get('/users', (req, res) => {

    verification.isValidAdmin(req.headers.token).then(isValid => {
        if (isValid) {

            //searching user by name or surname
            if (req.query.search) {

                const filterParams = {
                    TableName: USERS_TABLE,
                    ExpressionAttributeNames: {
                        "#name": "name"
                    },
                    FilterExpression: "contains(#name, :phrase) or contains(surname, :phrase)",
                    ExpressionAttributeValues: {
                        ":phrase": req.query.search
                    }
                }

                dynamoDb.scan(filterParams, (error, result) => {
                    if (error)
                        res.status(error.statusCode || 503).json({ error: error.message })
                    else if (result.Items)
                        res.status(200).json({ users: result.Items })
                })
            }

            else {

                const params = {
                    TableName: USERS_TABLE
                }

                // fetch all users from the database might change later due to pagination
                dynamoDb.scan(params, (error, result) => {
                    if (error)
                        res.status(error.statusCode || 503).json({ error: error.message })
                    else
                        res.status(200).json({ user: result.Items })
                })
            }
        }
        else
            res.status(401).json({ error: "User not authorised to make this request." })
    }).catch(error => { res.status(400).json({ error: error.message }) })
})

// //endpoint function that returns a user by userID
app.get('/users/:userId', (req, res) => {

    verification.isValidAdmin(req.headers.token).then(isValid => {

        if (isValid) {

            if (isNaN(req.params.userId) === false) {
                const params = {
                    TableName: USERS_TABLE,
                    Key: {
                        userId: parseInt(req.params.userId)
                    }
                }

                dynamoDb.get(params, (error, result) => {
                    if (error)
                        res.status(error.statusCode || 503).json({ error: error.message })
                    else if (result.Item)
                        res.status(200).json({ user: result.Item })
                    else
                        res.status(404).json({ error: "UserId " + req.params.userId + " not found" })
                })
            }
            else
                res.status(400).json({ error: "User Id provided provided is not a number" })
        }
        else
            res.status(401).json({ error: "User not authorised to make this request." })
    }).catch(error => { res.status(400).json({ error: error.message }) })
})

//endpoint function that create a new user
app.post('/users', (req, res) => {

    verification.isValidAdmin(req.headers.token).then(isValid => {

        if (isValid) {

            const user = req.body
            if (user.name && user.surname && user.password && user.imgUrl && user.email && user.privilege) {
                const params = {
                    TableName: USERS_TABLE,
                    Item: {
                        userId: userCount + 1,
                        name: user.name,
                        surname: user.surname,
                        password: user.password,
                        email: user.email,
                        imgUrl: user.imgUrl,
                        privilege: user.privilege
                    }
                }

                dynamoDb.put(params, (error, result) => {
                    if (error)
                        res.status(error.statusCode || 503).json({ error: error.message })
                    else {
                        userCount = userCount + 1
                        res.status(201).json({ user: "User successfully created" })
                    }
                })
            }
            else {
                const response = {
                    error: "Incomplete user supplied. Supply email, name, surname, imgUrl,  privilege and password",
                }
                res.status(400).json(response);
            }
        }
        else
            res.status(401).json({ error: "User not authorised to make this request." })
    }).catch(error => { res.status(400).json({ error: error.message }) })
})


//endpoint function thats logs in a user and sends that user a unique token key/ or priviledge key
app.post('/users/login', (req, res) => {

    const user = req.body
    if (user.email && user.password) {

        const params = {
            TableName: USERS_TABLE,
            IndexName: "authIndex",
            KeyConditionExpression: "email = :email and password = :password",
            ExpressionAttributeValues: {
                ":email": user.email,
                ":password": user.password
            }
        }

        dynamoDb.query(params, (error, result) => {
            if (error)
                res.status(error.statusCode || 503).json({ error: error.message });
            if (result.Count > 0) {
                const token = uuid.v1();
                const privilege = result.Items[0].privilege;// or type =  result.Items[item].privilege ... for (var item in result.Items)
                verification.saveAccessToken(token, privilege)
                    .then(() => {
                        res.status(200).json({ access_token: token })
                    })
                    .catch(error => {
                        res.status(503).json({ error: error.message })
                    })
            }
            else
                res.status(404).json({ error: "Incorrect email or password" });
        })
    }
    else
        res.status(400).json({ error: "Incomplete user credentials supplied" })
})

//endpoint function thats logs out a user and deletes the unique access key associated with its login
app.post('/users/logout', (req, res) => {

    verification.isValidUser(req.headers.token)
        .then(isValid => {
            if (isValid) {
                verification.deleteUserToken(req.headers.token)
                    .then(() => {
                        res.status(200).json({ message: "User successfully logged out " })
                    })
                    .catch(error => {
                        res.status(503).json({ error: error.message })
                    })
            }
            else
                res.status(401).json({ error: "User not authorised to make this request." })
        })
        .catch(error => { res.status(400).json({ error: error.message }) })
})

//endpoint function that updates  a user by userId
app.put('/users/:userId', (req, res) => {

    verification.isValidAdmin(req.headers.token).then(isValid => {

        if (isValid) {
            const user = req.body;
            if (isNaN(req.params.userId) === false && user.name && user.surname && user.password && user.imgUrl && user.email && user.privilege) {
                const params = {
                    TableName: USERS_TABLE,
                    Key: {
                        userId: parseInt(req.params.userId)
                    },
                    ExpressionAttributeNames: {
                        "#name": "name"
                    },
                    ExpressionAttributeValues: {
                        ":name": user.name,
                        ":surname": user.surname,
                        ":email": user.email,
                        ":password": user.password,
                        ":imgUrl": user.imgUrl,
                        ":privilege": user.privilege
                    },
                    UpdateExpression: "SET #name = :name, surname = :surname, email = :email, password = :password, imgUrl =:imgUrl, privilege = :privilege"
                }

                dynamoDb.update(params, (error, result) => {
                    if (error)
                        res.status(error.statusCode || 503).json({ error: error.message })
                    else
                        res.status(200).json({ message: "User updated successfully." })
                })
            }
            else {
                const errorStatusCode = isNaN(req.params.userId) ? 404 : 400;
                const message = isNaN(req.params.userId) ? "UserId " + req.params.userId + " not found" : "Incomplete user supplied.";
                res.status(errorStatusCode).json({ error: message })
            }
        }
        else
            res.status(401).json({ error: "User not authorised to make this request." })

    }).catch(error => { res.status(400).json({ error: error.message }) })
})

// //endpoint function that deletes a users by id
app.delete('/users/:userId', (req, res) => {

    verification.isValidAdmin(req.headers.token).then(isValid => {

        if (isValid) {
            if (!isNaN(req.params.userId)) {
                const userId = parseInt(req.params.userId);
                const params = {
                    TableName: USERS_TABLE,
                    Key: {
                        userId: userId
                    }
                }

                dynamoDb.delete(params, (error, result) => {
                    if (error)
                        res.status(error.statusCode || 503).json({ error: error.message })
                    else
                        res.status(200).json({ message: "User successfully deleted." });
                });
            }
            else
                res.status(400).json({ error: "User Id provided is not a number." });
        }
        else
            res.status(401).json({ error: "User not authorised to make this request." })
    }).catch(error => { res.status(400).json({ error: error.message }) })
});


// Handle in-valid route
app.all('*', function (req, res) {
    const response = { error: 'Route not found!!' }
    res.status(400).send(response)
});

// wrap express app instance with serverless http function
module.exports.handler = serverless(app);
