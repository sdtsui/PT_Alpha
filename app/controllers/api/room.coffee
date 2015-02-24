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

  router.delete '/remove', (req, res)->
    RoomService.remove(req, res)


  router.get '/layouts', RoomService.roomAuthorize, (req, res)->
    RoomService.getLayouts(req, res)

  router.post '/layouts/add', RoomService.roomAuthorize, (req, res)->
    RoomService.addLayout(req, res)

  router.put '/layouts/update', RoomService.roomAuthorize, (req, res)->
    RoomService.updateLayout(req, res)

  router.delete '/layouts/remove', RoomService.roomAuthorize, (req, res)->
    RoomService.deleteLayout(req, res)

