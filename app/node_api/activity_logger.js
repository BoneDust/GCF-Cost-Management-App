const requester = require('request-promise')
const activity_url = process.env.ACTIVITY_URL

module.exports = {

    logActivity: function (project_id, title, description, tokenKey) {

        if (project_id !== null && title !== null && description !== null) {

            const options = {
                method: 'POST',
                uri: activity_url,
                headers: {
                    token: tokenKey
                },
                body: {
                    project_id: project_id,
                    title: title,
                    description: description
                },
                json: true // Automatically stringifies the body to JSON
            }

            requester(options)
                .then(function (result) {
                    // POST succeeded...
                    return (true)
                })
                .catch(function (error) {
                    return (false)
                })
        }
        else
            return (false)
    }
}