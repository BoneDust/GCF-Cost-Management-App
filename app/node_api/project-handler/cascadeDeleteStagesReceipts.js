const AWS = require('aws-sdk')
const STAGES_TABLE = process.env.STAGES_TABLE
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
            const data = await dynamoDb.scan(params).promise()
            if (data.Items !== undefined) {
                var stages = data.Items
                for (var stage in stages) {
                    const params = {
                        TableName: STAGES_TABLE,
                        Key: {
                            stageId: stages[stage].stageId
                        }
                    }
                    const result = await dynamoDb.delete(params).promise()
                }
            }
        }
    }
}