const express = require('express');
const serverless = require('serverless-http');
const bodyParser = require('body-parser');
const uuid = require('uuid');//will be used to create the jwt token boon
const AWS = require('aws-sdk');
const app = express();

const USERS_TABLE = process.env.USERS_TABLE;
const dynamoDb = new AWS.DynamoDB.DocumentClient();
var userCount = 0;

app.use(bodyParser.json()); // to support JSON-encoded bodies
app.use(bodyParser.urlencoded({ extended: true})); // to support URL-encoded bodies

//endpoint function that returns all users
app.get('/users', (req, res) => {
    if(req.headers.token && req.headers.token.includes("admin"))
    {
        if (req.query.search)
        {
            const filterParams = {
                TableName: USERS_TABLE,
                ExpressionAttributeNames: {
                    "#name": "name",
                },
                FilterExpression: "contains(#name, :phrase) or contains(surname, :phrase)",
                ExpressionAttributeValues: {
                    ":phrase": req.query.search,
                },
            };

            dynamoDb.scan(filterParams, (error, result) => {
                if (error)
                {
                    const errorStatusCode = error.statusCode || 503;
                    const response = {
                        error: error.message,
                    };
                    res.status(errorStatusCode).json(response);
                } 
                if (result.Items)
                {
                    const responseStatusCode = 200;
                    const response = {
                        users: result.Items,        
                    };
                    res.status(responseStatusCode).json(response);
                }
            });
            return;
        }
        const params = {
            TableName: USERS_TABLE,
        };

        // fetch all users from the database might change later due to pagination
        dynamoDb.scan(params, (error, result) => {
            if (error)
            {
                const errorStatusCode = error.statusCode || 503;
                const response = {
                    error: error.message,
                };
                res.status(errorStatusCode).json(response);
                return;
            }
            const response = {
                user: result.Items,
                message: "A list  of all users",
            };
            res.json(response);
        });
    }
    else
    {
        const errorStatusCode = 401;
        const response = {
            error: "User not authorised to make this request. Add token key to request header",
        };
        res.status(errorStatusCode).json(response);
    }
});

//endpoint function that returns a user by userID
app.get('/users/:userId', (req, res) => {

    if (req.headers.token && req.headers.token.includes("admin"))
    {
        if (isNaN(req.params.userId) === false)
        {
            const params = {
                TableName: USERS_TABLE,
                Key: {
                    userId: parseInt(req.params.userId)
                },
            };

            dynamoDb.get(params, (error, result) => {
                if (error)
                {
                    const errorStatusCode = error.statusCode || 503;
                    const response = {
                        error: error.message,
                    };
                    res.status(errorStatusCode).json(response);
                    return;
                }
                if (result.Count > 0)
                {
                    const user = result.Item;
                    const responseStatusCode = 200;
                    const response = {
                        user: user,
                        message: "User retrieved successfully",
                    };
                    res.status(responseStatusCode).json(response);
                    return;
                }
            });
        }
        const errorStatusCode = 404;
        const response = {
            error: "UserId " + req.params.userId + " not found",
        };
        res.status(errorStatusCode).json(response);
    }
    else
    {
        const errorStatusCode = 401;
        const response = {
            error: "User not authorised to make this request. Add token to request header",
        };
        res.status(errorStatusCode).json(response);
    }
});
//create token table. if user logs out delete said token. isValidAdmin() && isValidUser()

//endpoint function that create a new user
app.post('/users', (req, res) => {

    if(req.headers.token && req.headers.token.includes("admin")){
        const user = req.body;
        if (user.name && user.surname && user.password && user.imgUrl && user.email && user.privilege)
        {
            const params = {
                TableName: USERS_TABLE,
                Item: {
                    userId: userCount + 1,
                    name: user.name,
                    surname: user.surname,
                    password: user.password,
                    email: user.email,
                    imgUrl: user.imgUrl,
                    privilege: user.privilege,
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
                    user: user,
                    message: "User successfully created",
                };
                userCount = userCount + 1;
                res.status(responseStatusCode).json(response);
            });
        }
        else
        {
            const errorStatusCode = 400;
            const response = {
                error: "Incomplete user supplied. Supply email, name, surname, imgUrl,  privilege and password lol",
            }
            res.status(errorStatusCode).json(response);
        }
    }
    else
    {
        const errorStatusCode = 401;
        const response = {
            error: "User not authorised to make this request. Add token to request header",
        };
        res.status(errorStatusCode).json(response);
    }

});


//endpoint function thats logs in a user and sends that user a unique token key/ or priviledge key
app.post('/users/login', (req, res) => {
    
    const user = req.body;
    if (user.email && user.password)
    {
        const params = {
            TableName: USERS_TABLE,
            IndexName: "authIndex",
            KeyConditionExpression: "email = :email and password = :password",
            ExpressionAttributeValues: {
                ":email": user.email,
                ":password": user.password,
            },
        };
    
        dynamoDb.query(params, (error, result) => {
            if (error)
            {
                const errorStatusCode = error.statusCode || 503;
                const response = {
                    error: error.message,
                };
                res.status(errorStatusCode).json(response);
            } 
            if (result.Items)
            {
                for (var item in result.Items)
                {
                    const responseStatusCode = 200;
                    const response = {
                        token: result.Items[item].privilege + "_" + uuid.v1(), // or token: result.Items[0].privilege + ...
                    };
                    res.status(responseStatusCode).json(response);
                    return;
                }
            }
            const errorStatusCode = 404;
            const response = {
                error: "Incorrect username or password",
            };
            res.status(errorStatusCode).json(response);
            
        });   
    }
    else
    {
        const errorStatusCode = 400;
        const response = {
            error: "Incomplete user credentials supplied",
        }
        res.status(errorStatusCode).json(response);
    }
  
})

//endpoint function that updates  a user by userId
app.put('/users/:userId', (req, res) => {
    if(req.headers.token && req.headers.token.includes("admin"))
    {
        const user = req.body;
        if (isNaN(req.params.userId) === false && user.name && user.surname && user.password && user.imgUrl && user.email && user.privilege)
        {
            const params = {
                TableName: USERS_TABLE,
                Key: {
                    userId: parseInt(req.params.userId),
                },
                ExpressionAttributeNames: {
                    "#name": "name",
                },
                ExpressionAttributeValues: { 
                    ":name" : user.name,
                    ":surname" : user.surname,
                    ":email" : user.email,
                    ":password" : user.password,
                    ":imgUrl" : user.imgUrl,
                    ":privilege" : user.privilege,
                },
                UpdateExpression: "SET #name = :name, surname = :surname, email = :email, password = :password, imgUrl =:imgUrl, privilege = :privilege",
            };

            dynamoDb.update(params, (error, result) => {        
                if (error)
                {
                    const errorStatusCode = error.statusCode || 503;
                    const response = {
                        error: error.message,
                    };
                    res.status(errorStatusCode).json(response);
                }
                if(result)
                {
                    const responseStatusCode = 200;
                    const response = {
                        message: "User updated successfully.", 
                    };
                    res.status(responseStatusCode).json(response);
                }
          });
        }
        else
        {
            const errorStatusCode = isNaN(req.params.userId)? 404 : 400;
            const message = isNaN(req.params.userId)? "UserId " + req.params.userId + " not found" : "Incomplete user supplied.";
            const response = {
                error:  message,
            }
            res.status(errorStatusCode).json(response);
         }
    }
    else
    {
        const errorStatusCode = 401;
        const response = {
            error: "User not authorised to make this request. Add token to request header",
        };
        res.status(errorStatusCode).json(response);
    }

});

//endpoint function that deletes a users by id
app.delete('/users/:userId', (req, res) => {
    if(req.headers.token && req.headers.token.includes("admin"))
    {
        if (!isNaN(req.params.userId))
        {
            const userId = parseInt(req.params.userId);
            const params = {
                TableName: USERS_TABLE,
                Key: {
                    userId: userId,
                },
            }

            dynamoDb.delete(params, (error, result) => {
                if (error)
                {
                    const errorStatusCode = error.statusCode || 503;
                    const response = {
                        error: error.message,
                    };
                    res.status(errorStatusCode).json(response);
                } 
                if (result)
                {
                    const responseStatusCode = 200;
                    const response = {
                        user: result.Item,
                        message : "User successfully deleted",
                    };
                    res.status(responseStatusCode).json(response);
                }
            });
        }
        else
        {
            const errorStatusCode = 404;
            const message = "UserId " +req.params.userId + " not found";
            const response = {
                error:  message,
            }
            res.status(errorStatusCode).json(response);
         }
    }
    else
    {
        const errorStatusCode = 401;
        const response = {
            error: "User not authorised to make this request. Add token to request header",
        };
        res.status(errorStatusCode).json(response);
    }

});


// Handle in-valid route
app.all('*', function(req, res) {
  const response = { data: null, message: 'Route not found!!' }
  res.status(400).send(response)
});

// wrap express app instance with serverless http function
module.exports.handler = serverless(app);
