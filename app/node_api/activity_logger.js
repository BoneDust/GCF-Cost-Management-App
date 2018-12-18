const requester = require('request-promise')
const axios = require('axios')
const activity_url = process.env.ACTIVITY_URL

module.exports = {

    logActivity: function (project_id, title, description, tokenKey) {

        if (project_id !== null && title !== null && description !== null) {

            const options = {
                data: {
                    project_id: project_id,
                    title: title,
                    description: description
                }
            }

            axios.post('https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/activities', options)
                .then(function (response) {
                    //handle success
                    return (true)
                })
                .catch(function (response) {
                    //handle error
                    return (false)
                });
            return (true)
        }
        else
            return (false)
    }
}