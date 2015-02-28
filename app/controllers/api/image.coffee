express  = require 'express'
router = express.Router()
api = require('../../../libs/authentication')
ImageService = require('../../services/image_service')

module.exports = (app, passport) ->
  app.use '/api/images', api.requiresLogin, router


  router.get "/", (req, res)->
    ImageService.all(req, res)

  router.post '/upload', (req, res)->
    ImageService.upload(req, res)

