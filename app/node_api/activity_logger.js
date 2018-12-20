const requester = require('request')
const activity_url = process.env.ACTIVITY_URL

module.exports = {

    logActivity: function (project_id, title, description, token) {

        if (project_id !== null && !isNaN(project_id) && title !== null && description !== null && token !== null) {

            const options = {
                uri: activity_url,
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