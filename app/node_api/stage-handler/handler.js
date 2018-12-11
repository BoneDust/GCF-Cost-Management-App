const express = require('express');
const serverless = require('serverless-http');
const bodyParser = require('body-parser');
const AWS = require('aws-sdk');
const app = express();

const STAGES_TABLE = process.env.STAGES_TABLE;
const dynamoDb = new AWS.DynamoDB.DocumentClient();
var stageCount = 0;

app.use(bodyParser.json()); // to support JSON-encoded bodies
app.use(bodyParser.urlencoded({ extended: true })); // to support URL-encoded bodies

//endpoint function that returns all stages eintlik must return by project
app.get('/stages', (req, res) => {
    const params = {
        TableName: STAGES_TABLE,
    };

    // fetch all stages from the database might change later due to pagination
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
            stage: result.Items,
            message: "A list  of all stages",
        };
        res.json(response);
    });

});

//endpoint function that returns a stage by stageID
app.get('/stages/:stageId', (req, res) => {
    if (isNaN(req.params.stageId) === false) {
        const params = {
            TableName: STAGES_TABLE,
            Key: {
                stageId: parseInt(req.params.stageId)
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
});

//endpoint function that create a new stage
app.post('/stages', (req, res) => {
    const stage = req.body;
    if (stage.project_id && stage.stage_name && stage.description && stage.status && stage.before_pic_url && stage.start_date && estimated_duration) {
        const params = {
            TableName: STAGES_TABLE,
            Item: {
                stageId: stageCount + 1,
                project_id: stage.project_id,
                stage_name: stage.stage_name,
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
    else {
        const errorStatusCode = 400;
        const response = {
            error: "Incomplete stage supplied. Supply poject_id, stage_name, descriptiom, status,  before_pic_url, start_date and estimated_duration",
        }
        res.status(errorStatusCode).json(response);
    }
});

//endpoint function that updates  a stage by stageId
app.put('/stages/:stageId', (req, res) => {
    const stage = req.body;
    if (isNaN(req.params.stageId) === false && stage.project_id && stage.stage_name && stage.description && stage.status && stage.before_pict_url && stage.after_pic_url) {
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
                ":before_pict_url": stage.before_pict_url,
                ":after_pic_url": stage.after_pic_url,
                ":start_date": stage.start_date,
                ":end_date": stage.end_date,
                ":estimated_duration": stage.estimated_duration,
            },
            UpdateExpression: "SET project_id = :project_id, stage_name = :stage_name, description = :description, status = :status, before_pict_url = :before_pict_url, after_pic_url = after_pic_url, start_date = :start_date, end_date = :end_date, estimated_duration = :estimated_duration",
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
                    message: "Stage updated successfully.",
                };
                res.status(responseStatusCode).json(response);
            }
        });
    }
    else {
        const errorStatusCode = isNaN(req.params.stageId) ? 404 : 400;
        const message = isNaN(req.params.stageId) ? "StageId " + req.params.userId + " not found" : "Incomplete stage supplied.";
        const response = {
            error: message,
        }
        res.status(errorStatusCode).json(response);
    }

});

//endpoint function that deletes a users by id
app.delete('/stages/:stageId', (req, res) => {

    if (!isNaN(req.params.stageId)) {
        const stageId = parseInt(req.params.stageId);
        const params = {
            TableName: USERS_TABLE,
            Key: {
                stageId: stageId,
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
                    stage: result.Item,
                    message: "Stage successfully deleted",
                };
                res.status(responseStatusCode).json(response);
            }
        });
    }
    else {
        const errorStatusCode = 404;
        const message = "StageId " + req.params.stageId + " not found";
        const response = {
            error: message,
        }
        res.status(errorStatusCode).json(response);
    }
});
///

// Handle in-valid route
app.all('*', function (req, res) {
    const response = { data: null, message: 'Route not found!!' }
    res.status(400).send(response)
});

// wrap express app instance with serverless http function
module.exports.handler = serverless(app);
