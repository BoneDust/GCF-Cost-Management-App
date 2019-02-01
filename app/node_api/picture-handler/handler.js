const express = require('express')
const bodyParser = require('body-parser')
const multer = require('multer')
const multerS3 = require('multer-s3')
const serverless = require('serverless-http')
const AWS = require('aws-sdk')
const verification = require('./../verification')
const bucket = process.env.S3_PICTURE_BUCKET
const app = express()
const dynamoDb = new AWS.DynamoDB.DocumentClient()

const s3 = new AWS.S3()

app.use(bodyParser.json());

//this works

var upload = multer({
    storage: multerS3({
        s3: s3,
        bucket: bucket,
        acl: 'public-read',
        key: function (req, file, cb) {
            cb(null, new Date().toISOString() + '-' + file.originalname)
        }
    })
});


app.post('/pictures', upload.single('somefile', 1), function (req, res) {
    res.status(200).json({ url: req.file.location });
});



// Handle in-valid route
app.all('*', function (req, res) {
    const response = { data: null, message: 'Route not found!!' }
    res.status(400).send(response)
})

// wrap express app instance with serverless http function
module.exports.handler = serverless(app)