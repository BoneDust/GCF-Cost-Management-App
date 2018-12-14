const request = require('request-promise')
const activity_url = process.env.ACTIVITY_URL
module.exports = {

    logActivity: function (project_id, title, description, token) {

        if (project_id !== null && title !== null && description !== null) {
            var options = {
                method: 'POST',
                uri: activity_url,
                headers: {
                    token: token
                },
                body: {
                    project_id: project_id,
                    title: title,
                    description: description
                },
                json: true // Automatically stringifies the body to JSON
            }

            request(options)
                .then(function (result) {
                    // POST succeeded...
                    return (true)
                })
                .catch(function (error) {
                    return (false)
                });
        }
        else
            return (false)
    }
}