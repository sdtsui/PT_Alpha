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

  router.delete '/remove', (req, res)->
    ImageService.remove(req, res)

  router.put '/update', (req, res)->
    ImageService.update(req, res)

