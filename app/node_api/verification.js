const AWS = require('aws-sdk');
const TOKEN_TABLE = process.env.TOKENS_TABLE;
const dynamoDb = new AWS.DynamoDB.DocumentClient();

module.exports = {
    isValidAdmin: function(token)
    {
        if (!token)
            return (false);
        else
        {
            const params = {
                TableName: TOKEN_TABLE,
                Key: {
                    token: token,
                },
            };
            dynamoDb.get(params, (error, result) => {
                if (error)
                    return (false);
                else if (result.Count > 0)
                {
                    const key = result.Item;
                    if (key.privilege === 'admin')
                        return (true);
                    else
                        return (false);
                }
                else
                    return (false);
            });
        }
    },

    isValidUser: function(token)
    {
        if (!token)
            return (false);
        else
        {
            const params = {
                TableName: TOKEN_TABLE,
                Key: {
                    token: token,
                },
            };
            dynamoDb.get(params, (error, result) => {
                if (error)
                    return (false);
                else if (result.Count > 0)
                    return (true);
                else
                    return (false);
            });
        }
    },

    saveUsertoken: function(token, privilege)
    {
        const params = {
            TableName: TOKEN_TABLE,
            Item: {
                token: token,
                privilege: privilege,
            },
        };    
        dynamoDb.put(params, (error) =>{
            if(error)
                console.log(error);
        });
    },

    deleteUserToken: function (token)
    {
        const params = {
            TableName: TOKEN_TABLE,
            Key: {
                token: token,
            },
        }    
        dynamoDb.delete(params, (error)  =>
        {
            if (error)
                console.log(error);
        });
    }
};