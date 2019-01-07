const AWS = require('aws-sdk')
const PROJECT_TABLE = process.env.PROJECTS_TABLE
const CLIENT_TABLE = process.env.CLIENTS_TABLE
const USER_TABLE = process.env.USERS_TABLE
const TOKEN_TABLE = process.env.TOKENS_TABLE
const STAGE_TABLE = process.env.STAGES_TABLE
const dynamoDb = new AWS.DynamoDB.DocumentClient()

module.exports = {

    getActionPerformerName: async function (tokenKey) {

        if (tokenKey !== undefined) {
            const params = {
                TableName: TOKEN_TABLE,
                Key: {
                    token: tokenKey
                }
            }
            const data = await dynamoDb.get(params).promise()
            if (data.Item !== undefined)
                return (data.Item.username)
            else
                return ("Unknown")
        }
        else
            return ("Unknown")
    },

    getUsername: async function (userId) {

        if (user !== undefined && !isNaN(userId)) {
            const params = {
                TableName: USER_TABLE,
                Key: {
                    userId: parseInt(userId)
                }
            }
            const data = await dynamoDb.get(params).promise()
            if (data.Item !== undefined)
                return (data.Item.name + " " + data.Item.surname)
            else
                return (data)
        }
        else
            return ("Unknown")
    },

    getProjectName: async function (projectId) {

        if (projectId !== undefined && !isNaN(projectId)) {
            const params = {
                TableName: PROJECT_TABLE,
                Key: {
                    projectId: parseInt(projectId)
                }
            }
            const data = await dynamoDb.get(params).promise()
            if (data.Item !== undefined)
                return (data.Item.name)
            else
                return ("Unknown")
        }
        else
            return ("Unknown")
    },

    getClientName: async function (clientId) {
        if (clientId !== undefined && !isNaN(clientId)) {
            const params = {
                TableName: CLIENT_TABLE,
                Key: {
                    clientId: parseInt(clientId)
                }
            }
            const data = await dynamoDb.get(params).promise()
            if (data.Item !== undefined)
                return (data.Item.name)
            else
                return ("Unknown")
        }
        else
            return ("Unknown")
    },

    getStageName: async function (stageId) {
        if (stageId !== undefined && !isNaN(stageId)) {
            const params = {
                TableName: STAGE_TABLE,
                Key: { stageId: parseInt(stageId) }
            }
            const data = await dynamoDb.get(params).promise()
            if (data.Item !== undefined)
                return (data.Item.stage_name)
            else
                return ("Unknown")
        }
        else
            return ("Unknown")
    }
}