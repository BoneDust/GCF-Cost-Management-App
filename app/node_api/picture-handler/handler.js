const express = require('express')
const bodyParser = require('body-parser')
const multer = require('multer')
const multerS3 = require('multer-s3')
const serverless = require('serverless-http')
const AWS = require('aws-sdk')
const verification = require('./../verification')
const BUCKET = process.env.S3BUCKET
const app = express()
const dynamoDb = new AWS.DynamoDB.DocumentClient()

const s3 = new AWS.S3()


app.use(bodyParser.json()) // to support JSON-encoded bodies
app.use(bodyParser.urlencoded({ extended: true })) // to support URL-encoded bodies

app.use(multer({
    dest: './users/',
    limits: { fileSize: 1024 * 1024 * 10 },
    /*rename: function (fieldname, filename) {
      var time = new Date().getTime();
      return filename.replace(/\W+/g, '-').toLowerCase() + time;
    },*/
    onFileUploadData: function (file, data, req, res) {
        // file : { fieldname, originalname, name, encoding, mimetype, path, extension, size, truncated, buffer }
        var params = {
            Bucket: S3BUCKET,
            Key: file.name,
            Body: data,
            ACL: 'public-read'
        };

        s3.upload(params, function (error, result) {
            if (error) {
                console.log(error)
            }
            else {
                console.log(result)
            }
        })
    }
}))

app.post('/pictures', function (req, res) {

    res.status(200).json({ lol: "error, no file chosen" })
})

























/*

const multerS3Config = multerS3({
    s3: s3,
    bucket: S3BUCKET,
    key: function (req, file, cb) {
        cb(null, new Date().toISOString() + '-lerole.png')
    }
})

const upload = multer({
    storage: multerS3Config,
    limits: {
        fileSize: 1024 * 1024 * 5 // we are allowing only 5 MB files
    }
})
*/











/*
app.post('/pictures', multer({ limits: { fileSize: 10 * 1024 * 1024 } }), function (req, res) {

    if (!req.file)
        return res.status(403).json('expect 1 file upload named file1');

    var file = req.file

    var params = {
        Bucket: S3BUCKET,
        ACL: 'public-read',
        Body: file.buffer.data,
        Key: "budas",
        ContentType: 'application/octet-stream' // force download if it's accessed as a top location
    }

    s3.upload(params, function (error, data) {
        if (error)
            return res.status(error.statusCode || 500).json({ error: error.message })
        else
            res.status(200).json({ url: data })
    })
})*/






























/*





app.post('/pictures', upload.array('somefile'), (req, res) => {
    verification.isValidUser(req.headers.token)
        .then(isValid => {
            if (isValid) {
                for (var file in req.files) {
                    var params = {
                        Bucket: S3BUCKET,
                        Key: req.files[file].originalname,
                        Body: req.files[file].buffer.data,// data,
                        ACL: 'public-read'
                    }

                    s3.upload(params, (error, result) => {
                        if (error)
                            res.status(error.statusCode || 503).json({ error: error.message })
                        else {
                            res.status(200).json({ url: result })
                        }
                    })
                }

                //res.status(200).json({ body: req.body, file_data: req.files })//.send();
            }
            else
                res.status(401).json({ error: "User not authorised to make this request." })
        })
        .catch(error => { res.status(400).json({ error: error.message }) })
})


*/




































// Handle in-valid route
app.all('*', function (req, res) {
    const response = { data: null, message: 'Route not found!!' }
    res.status(400).send(response)
})

// wrap express app instance with serverless http function
module.exports.handler = serverless(app)