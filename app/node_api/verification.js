const AWS = require('aws-sdk')
const TOKEN_TABLE = process.env.TOKENS_TABLE
const dynamoDb = new AWS.DynamoDB.DocumentClient()

module.exports = {

    isValidAdmin: async function (tokenKey) {

        if (tokenKey !== undefined) {
            const params = {
                TableName: TOKEN_TABLE,
                Key: {
                    token: tokenKey
                }
            }
            const data = await dynamoDb.get(params).promise()
            return (data.Item !== undefined && data.Item.privilege === "admin")
        }
        else
            return false
    },

    isValidUser: async function (tokenKey) {

        if (tokenKey !== undefined) {
            const params = {
                TableName: TOKEN_TABLE,
                Key: {
                    token: tokenKey
                }
            }
            const data = await dynamoDb.get(params).promise()
            return (data.Item !== undefined)
        }
        else
            return false
    },

    saveAccessToken: async function (tokenKey, privilege) {

        const params = {
            TableName: TOKEN_TABLE,
            Item: {
                token: tokenKey,
                privilege: privilege
            }
        }
        await dynamoDb.put(params).promise()
    },

    deleteUserToken: async function (tokenKey) {
        const params = {
            TableName: TOKEN_TABLE,
            Key: {
                token: tokenKey
            }
        }
        await dynamoDb.delete(params).promise()
    }
}