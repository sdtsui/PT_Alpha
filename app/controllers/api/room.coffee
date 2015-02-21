express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
api = require('../../../libs/authentication')
RoomService = require('../../services/room_service')

module.exports = (app, passport) ->
  app.use '/api/rooms', api.requiresLogin, router

  router.get '/', (req, res)->
    RoomService.getAll(req, res)

  router.post '/add', (req, res)->
    RoomService.add(req, res)

  router.put '/update', (req, res)->
    RoomService.update(req, res)


  router.get '/layouts', RoomService.roomAuthorize, (req, res)->
    RoomService.getLayouts(req, res)

  router.post '/layouts/add', (req, res)->
    RoomService.addLayout(req, res)

  router.put '/layouts/update', (req, res)->
    RoomService.updateLayout(req, res)

