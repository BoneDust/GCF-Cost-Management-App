const requester = require('request')
const https = require('https')
var querystring = require('querystring');
const activity_url = process.env.ACTIVITY_URL

module.exports = {

    logActivity: function (project_id, title, description, token) {

        if (project_id !== null && title !== null && description !== null && token !== null) {

            const options = {
                uri: activity_url,// 'https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/activities',
                method: 'POST',
                headers: {
                    'token': token
                },
                form: {
                    project_id: project_id,
                    title: title,
                    description: description
                },
                json: true
            }
            // Start the requestS
            requester(options)
        }

    }
}