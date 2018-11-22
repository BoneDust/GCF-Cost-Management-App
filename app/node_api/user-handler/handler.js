const express = require('express');
const serverless = require('serverless-http');
const bodyParser = require('body-parser');
const uuid = require('uuid');//will be used to create the jwt token
const AWS = require('aws-sdk');
const app = express();

const USERS_TABLE = process.env.USERS_TABLE;
const dynamoDb = new AWS.DynamoDB.DocumentClient();

app.use(bodyParser.json({ strict: true})); //i dont know what this does

//endpoint function that returns all users
app.get('/users', (req, res) => {
	const params = {
		TableName: USERS_TABLE,
	};

	// fetch all users from the database
  	dynamoDb.scan(params, (error, result) => {
		if (error){
			//console.log(error);
			const errorStatusCode = error.statusCode || 501;
			const response = {
				users: null,
				message: err.message,
			};
			res.status(errorStatusCode).json(response);
			return;
		}
		const response = {
			user: result.Items,
			message: "a list  of all users",
		};
		res.json(response);
	});
});

//endpoint function that returns a user by id
app.get('/users/:userId', (req, res) => {

	const params = {
		TableName: USERS_TABLE,
		Key: {
			userId: req.params.userId,
		},
	};

	dynamoDb.get(params, (error, result) => {
		if (error) {
			//console.log(error);
			const errorStatusCode = 400;
			const response = {
				error: "Could not retrieve user",
			};
		  	res.status(errorStatusCode).json(response);
		}

		if (result.Item) {
			const user = result.Item;//const  {userId, name, surname, username, password, imgUrl, email, priviledge} = result.Item; need to check this out
			const response = {
				user: user,
				message: "User retrieved successfully",
			};
			res.json(response);
		}
		else {
			const errorStatusCode = 404;
			const response = {
				error: "User not found",
			};
		  	res.status(errorStatusCode).json(response);
		}
	});
})
// TODO: boooom need to body-bodyParser
//endpoint function that create a new user
app.post('/users', (req, res) => {

	const { userId, name } = req.body;
	const params = {
		TableName: USERS_TABLE,
		Item: {
			userId: uuid.v1(),
			name: data.text,
			surname: false,
			username: timestamp,
			password: timestamp,
			imgUrl: ,
			email: ,
			priviledge: ,
		},
	};

	dynamoDb.put(params, (error) => {
    	if (error) {
      		//console.log(error);
			const errorStatusCode = 400;
			const response = {
				error: "Could not create user",
			};
		  	res.status(errorStatusCode).json(response);
    	}
    	res.json({ userId, name });
	});
});


//endpoint function thats logs in a user and sends that user a unique api key/ or priviledge key
app.post('/users/login', (req, res) => {

})



//endpoint function that updates  a user by id
app.put('/users/:id', (req, res) => {

})

//endpoint function that deletes a users by id
app.delete('/users/:id', (req, res) => {

})



// Handle in-valid route
app.all('*', function(req, res) {
  const response = { data: null, message: 'Route not found!!' }
  res.status(400).send(response)
})

// wrap express app instance with serverless http function
module.exports.handler = serverless(app)
