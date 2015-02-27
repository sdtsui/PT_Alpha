express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
api = require('../../../libs/authentication')
S3Service = require('../../services/s3_service')

module.exports = (app, passport) ->
  app.use '/api/s3', api.requiresLogin, router

  router.get '/policy', (req, res)->
    S3Service.getS3Policy(req, res)
