const requester = require('request-promise')
const axios = require('axios')
const activity_url = process.env.ACTIVITY_URL

module.exports = {

    logActivity: function (project_id, title, description, tokenKey) {

        if (project_id !== null && title !== null && description !== null) {

            const options = {
                headers: {
                    token: tokenKey
                },
                body: {
                    project_id: project_id,
                    title: title,
                    description: description
                }//,
                //json: true // Automatically stringifies the body to JSON
            }


            /*const response = await axios({
                method: 'post',
                url: 'https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/activities',
                data: {
                    project_id: project_id,
                    title: title,
                    description: description
                },
                headers: {
                    'token': tokenKey,
                }
            })*/




            const options = {
                method: 'post',
                url: 'https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/activities',
                data: {
                    project_id: project_id,
                    title: title,
                    description: description
                },
                // headers: {
                //     'Content-Type': 'application/json',
                //     'token': tokenKey
                // }
            }
            axios(options)
                .then(function (response) {
                    //handle success
                    return (true)
                })
                .catch(function (response) {
                    //handle error
                    return (false)
                });


        }
        else
            return (false)
    }
}