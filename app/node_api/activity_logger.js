const requester = require('request')
const axios = require('axios')
const activity_url = process.env.ACTIVITY_URL

module.exports = {

    logActivity: function (project_id, title, description, tokenKey) {

        if (project_id !== null && title !== null && description !== null) {

            /*const options = {
                //data: {
                project_id: project_id,
                title: title,
                description: description
                //}
            }

            var result// = true
            axios.post('https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/activities', options)
                .then(function (response) {
                    //handle success
                    result = true
                })
                .catch(function (error) {
                    //handle error
                    result = false
                });
            return (result)*/





            /*
            // Set the headers
            var headers = {
                'Content-Type': 'application/json'
            }

            // Configure the request
            var options = {
                url: 'https://m2xilo8zvg.execute-api.us-east-1.amazonaws.com/dev/activities',
                method: 'POST',
                headers: headers,
                body: {
                    project_id: project_id,
                    title: title,
                    description: description
                }
            }

            // Start the request
            requester(options, function (error, response, body) {
                if (!error && response.statusCode == 201) {
                    // Print out the response body
                    console.log(body)
                }
            })*/

            var options = {
                host: "developer.api.autodesk.com",
                path: "/oss/v1/buckets",
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                    "Authorization": "Bearer token"
                }
            };

            var bucket = {};
            bucket.name = "shiyas-bucket";

            var file = {};
            file.name = "sometext.txt";

            var options = {
                host: "developer.api.autodesk.com",
                path: "/oss/v1/buckets/" + bucket.name + "/objects/" + file.name,
                method: "PUT",
                headers: {
                    "Content-Type": "application/octet-stream",
                    "Authorization": "Bearer token"
                }
            };

            var req = http.request(options, function (res) {
                var responseString = "";

                res.on("data", function (data) {
                    responseString += data;
                    // save all the data from response
                });
                res.on("end", function () {
                    console.log(responseString);
                    // print to console when response ends
                });
            });

            var reqBody = "sometext";
            req.write(reqBody);
            req.end();

        }
        // else
        //   return (false)
    }
}