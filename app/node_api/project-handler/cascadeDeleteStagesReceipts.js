const AWS = require('aws-sdk')
const STAGES_TABLE = process.env.STAGES_TABLE
const RECEIPTS_TABLE = process.env.RECEIPT_TABLE
const dynamoDb = new AWS.DynamoDB.DocumentClient()

module.exports = {

    deleteStagesByProject: async function (project_id) {
        if (project_id !== undefined && !isNaN(project_id)) {
            const params = {
                TableName: STAGES_TABLE,
                FilterExpression: "project_id = :project_id",
                ExpressionAttributeValues: {
                    ":project_id": parseInt(project_id)
                }
            }
            const stages = await dynamoDb.get(params).promise()
            if (stages.Items !== undefined) {
                for (var stage in stages) {
                    const params = {
                        TableName: STAGES_TABLE,
                        Key: {
                            stageId: stage.stageId
                        }
                    }
                    const result = await dynamoDb.delete(params).promise()
                }
            }
        }
    },

    deleteReceiptsByProject: async function (project_id) {
        if (project_id !== undefined && !isNaN(project_id)) {
            const params = {
                TableName: RECEIPTS_TABLE,
                FilterExpression: "project_id = :project_id",
                ExpressionAttributeValues: {
                    ":project_id": parseInt(project_id)
                }
            }
            const receipts = await dynamoDb.get(params).promise()
            if (receipts.Items !== undefined) {
                for (var receipt in receipts) {
                    const params = {
                        TableName: RECEIPTS_TABLE,
                        Key: {
                            receiptId: receipt.receiptId
                        }
                    }
                    const result = await dynamoDb.delete(params).promise()
                }
            }
        }
    }
}