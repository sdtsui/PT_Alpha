express  = require 'express'
router = express.Router()
api = require('../../../libs/authentication')
MenuService = require('../../services/menu_service')

module.exports = (app, passport) ->
  app.use '/api/menus', api.requiresLogin, router


  router.get "/", (req, res)->
    MenuService.all(req, res)

  router.post '/add', (req, res)->
    MenuService.add(req, res)

  router.put '/update', (req, res)->
    MenuService.update(req, res)
