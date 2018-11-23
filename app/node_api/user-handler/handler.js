const express = require('express');
const serverless = require('serverless-http');
const bodyParser = require('body-parser');
const uuid = require('uuid');//will be used to create the jwt token
const AWS = require('aws-sdk');
const app = express();

const USERS_TABLE = process.env.USERS_TABLE;
const dynamoDb = new AWS.DynamoDB.DocumentClient();

app.use(bodyParser.json({ strict: true})); // to support JSON-encoded bodies

app.use(bodyParser.urlencoded({ extended: true})); // to support URL-encoded bodies

//endpoint function that returns all users
app.get('/users', (req, res) => {
    if(req.headers.token && req.headers.token.includes("admin")){
        const params = {
            TableName: USERS_TABLE,
        };

        // fetch all users from the database
        dynamoDb.scan(params, (error, result) => {
            if (error){
                //console.log(error);
                const errorStatusCode = error.statusCode || 503;
                const response = {
                    users: {},
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
    }
    else
    {
        const errorStatusCode = 401;
        const response = {
            error: "User not authorised to make this request",
        };
        res.status(errorStatusCode).json(response);
    }
});

//endpoint function that returns a username
app.get('/users/:username', (req, res) => {

    if(req.headers.token && req.headers.token.includes("admin")){
        const params = {
            TableName: USERS_TABLE,
            Key: {
                username: req.params.username,
            },
        };

        dynamoDb.get(params, (error, result) => {
            if (error) {
                //console.log(error);
                const errorStatusCode = 503;
                const response = {
                    error: "Could not retrieve user",
                };
                res.status(errorStatusCode).json(response);
            }

            if (result.Item) {
                const user = result.Item;
                const responseStatusCode = 200;
                const response = {
                    user: user,
                    message: "User retrieved successfully",
                };
                res.status(responseStatusCode).json(response);
            }
            else {
                const errorStatusCode = 404;
                const response = {
                    error: "User not found",
                };
                res.status(errorStatusCode).json(response);
            }
        });
    }
    else
    {
        const errorStatusCode = 401;
        const response = {
            error: "User not authorised to make this request",
        };
        res.status(errorStatusCode).json(response);
    }
});


//endpoint function that create a new user
app.post('/users', (req, res) => {

   // if(req.body.token && req.body.token.includes("admin")){
        const user = req.body;
        if (user.username && user.name && user.surname && user.password && user.imgUrl && user.email && user.priviledge)
        {
            const params = {
                TableName: USERS_TABLE,
                Item: {
                    username: user.username,
                    name: user.name,
                    surname: user.surname,
                    password: user.password,
                    imgUrl: user.imgUrl,
                    email: user.email,
                    priviledge: user.priviledge,
                },
            };
        
            dynamoDb.put(params, (error) => {
                if (error) {
                    //console.log(error);
                    const errorStatusCode = 503;
                    const response = {
                        error: error.message,
                    };
                    res.status(errorStatusCode).json(response);
                    return;
                }
                const responseStatusCode = 200;
                const response = {
                    user: user,
                    message: "User successfully created",
                };
                res.status(responseStatusCode).json(response);
            });
        }
        else{
            const errorStatusCode = 400;
            const response = {
                error: "Incomplete user supplied",
            }
            res.status(errorStatusCode).json(response);
        }
   /* }
    else
    {
        const errorStatusCode = 401;
        const response = {
            error: "User not authorised to make this request",
        };
        res.status(errorStatusCode).json(response);
    }*/

});


//endpoint function thats logs in a user and sends that user a unique api key/ or priviledge key
app.post('/users/login', (req, res) => {
    
    const user = req.body;
    if (user.username && user.password){
        const params = {
            TableName: USERS_TABLE,
            Key: {
                username: user.username,
            },
        };
    
        dynamoDb.get(params, (error, result) => {
            if (error) {
                  //console.log(error);
                const errorStatusCode = 503;
                const response = {
                    error: "Could not authenticate user",
                };
                res.status(errorStatusCode).json(response);
                return;
            } 
            if (result.Item)
            {
                if (result.Item.password === user.password)
                {
                    const responseStatusCode = 202;

                    const response = {
                        token: result.Item.priviledge + "_" + uuid.v1(),
                    };
                    res.status(responseStatusCode).json(response);
                } 
                else{
                    const errorStatusCode = 404;
                    const response = {
                        error: "Invalid password",
                    };
                  res.status(errorStatusCode).json(response);
               }
            }
            else
            {
                const errorStatusCode = 404;
                const response = {
                    error: "Invalid username",
                };
                  res.status(errorStatusCode).json(response);
            }
        
        });   
    }
    else{
        const errorStatusCode = 400;
        const response = {
            error: "Incomplete user credentials supplied",
        }
        res.status(errorStatusCode).json(response);
    }
  
})



//endpoint function that updates  a username
/*app.put('/users/:username', (req, res) => {
    if(req.body.token && req.body.token.includes("admin")){
    

        const params = {
            TableName: USERS_TABLE,
            Key: {
              username: req.params.username,
            },
            ExpressionAttributeNames: {
              '#todo_text': 'text',
            },
            ExpressionAttributeValues: {
              ':text': data.text,
              ':checked': data.checked,
              ':updatedAt': timestamp,
            },
            UpdateExpression: 'SET #todo_text = :text, checked = :checked, updatedAt = :updatedAt',
            ReturnValues: 'ALL_NEW',
          };
        
          // update the todo in the database
          dynamoDb.update(params, (error, result) => {
            // handle potential errors
            if (error) {
              console.error(error);
              callback(null, {
                statusCode: error.statusCode || 501,
                headers: { 'Content-Type': 'text/plain' },
                body: 'Couldn\'t fetch the todo item.',
              });
              return;
            }



    }

    else
    {
        const errorStatusCode = 401;
        const response = {
            error: "User not authorised to make this request",
        };
        res.status(errorStatusCode).json(response);
    }

})*/

/*endpoint function that deletes a users by id
app.delete('/users/:id', (req, res) => {

})
*/


// Handle in-valid route
app.all('*', function(req, res) {
  const response = { data: null, message: 'Route not found!!' }
  res.status(400).send(response)
})

// wrap express app instance with serverless http function
module.exports.handler = serverless(app)
