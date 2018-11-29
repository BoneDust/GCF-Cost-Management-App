const express = require('express');
const serverless = require('serverless-http');
const bodyParser = require('body-parser');
const uuid = require('uuid');//will be used to create the jwt token boon
const AWS = require('aws-sdk');
const app = express();

const STAGES_TABLE = process.env.STAGES_TABLE;
const dynamoDb = new AWS.DynamoDB.DocumentClient();
var stageCount = 0;

app.use(bodyParser.json()); // to support JSON-encoded bodies
app.use(bodyParser.urlencoded({ extended: true})); // to support URL-encoded bodies

//endpoint function that returns all stages
app.get('/stages', (req, res) => {
    if(req.headers.token && req.headers.token.includes("admin"))
    {
        if (req.query.search)
        {
            const filterParams = {
                TableName: STAGES_TABLE,
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
                        stages: result.Items,        
                    };
                    res.status(responseStatusCode).json(response);
                }
            });
            return;
        }
        const params = {
            TableName: STAGES_TABLE,
        };

        // fetch all stages from the database might change later due to pagination
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
                stage: result.Items,
                message: "A list  of all stages",
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

//endpoint function that returns a stage by stageID
app.get('/stages/:stageId', (req, res) => {
    if (req.headers.token && req.headers.token.includes("admin"))
    {
        if (isNaN(req.params.stageId) === false)
        {
            const params = {
                TableName: STAGES_TABLE,
                Key: {
                    stageId: parseInt(req.params.stageId)
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
                    const stage = result.Item;
                    const responseStatusCode = 200;
                    const response = {
                        stage: stage,
                        message: "Stage retrieved successfully",
                    };
                    res.status(responseStatusCode).json(response);
                    return;
                }
            });
        }
        const errorStatusCode = 404;
        const response = {
            error: "StageId " + req.params.stageId + " not found",
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

//endpoint function that create a new stage
app.post('/stages', (req, res) => {
    if(req.headers.token && req.headers.token.includes("admin")){
        const stage = req.body;
        if (stage.project_id && stage.name && stage.description && stage.status && stage.before_pict_url && stage.start_date && estimated_duration)
        {
            const params = {
                TableName: STAGES_TABLE,
                Item: {
                    stageId: stageCount + 1,
                    name: stage.name,
                    description: stage.description,
                    status: stage.status,
                    before_pict_url: stage.before_pict_url,
                    after_pic_url: "",
                    start_date: stage.start_date,
                    end_date: "",
                    estimated_duration: stage.estimated_duration,
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
                    stage: stage,
                    message: "Stage successfully created",
                };
                StageCount = StageCount + 1;
                res.status(responseStatusCode).json(response);
            });
        }
        else
        {
            const errorStatusCode = 400;
            const response = {
                error: "Incomplete stage supplied. Supply email, name, surname, imgUrl,  privilege and password lol",
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

TODO: //stage/stageid {put}{delete}

// Handle in-valid route
app.all('*', function(req, res) {
    const response = { data: null, message: 'Route not found!!' }
    res.status(400).send(response)
  });
  
  // wrap express app instance with serverless http function
  module.exports.handler = serverless(app);