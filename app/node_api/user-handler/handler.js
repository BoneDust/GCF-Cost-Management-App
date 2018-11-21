const express = require('express');
const serverless = require('serverless-http');
const bodyParser = require('body-parser');
const aws = require('aws-sdk');
const app = express()

const USERS_TABLE = process.env.USERS_TABLE;
const dynamoDb = new AWS.DynamoDB.DocumentClient();

app.use(bodyParser.json())//i dont know what this does
//app.use(bodyParser.urlencoded({ extended: true }))// this too i dont know

//endpoint function that returns all users
app.get('/users', (req, res) => 
	{
		const 
		res.status(200).json
		({
		
			message: 'boom'
		})



	const params = {
    	TableName: process.env.DYNAMODB_TABLE,
    	Item: {
      		id: uuid.v1(),
      		text: data.text,
      		checked: false,
      		createdAt: timestamp,
      		updatedAt: timestamp,
    	},
  };

  // write the todo to the database
  dynamoDb.put(params, (error) => {
    // handle potential errors
    if (error) {
      console.error(error);
      callback(null, {
        statusCode: error.statusCode || 501,
        headers: { 'Content-Type': 'text/plain' },
        body: 'Couldn\'t create the todo item.',
      });
      return;
    }
	}

	  dynamoDb.get(params, (error, result) => {
    if (error) {
      console.log(error);
      res.status(400).json({ error: 'Could not get user' });
    }
    if (result.Item) {
      const {userId, name} = result.Item;
      res.json({ userId, name });
    } else {
      res.status(404).json({ error: "User not found" });
    }
  });
);

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
