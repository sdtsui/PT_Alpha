express  = require 'express'
router = express.Router()
api = require('../../../libs/authentication')
MenuItemService = require('../../services/menu_item_service')

module.exports = (app, passport) ->
  app.use '/api/menu_items', api.requiresLogin, router


  router.get "/", (req, res)->
    MenuItemService.all(req, res)

  router.post '/add', (req, res)->
    MenuItemService.add(req, res)

  router.put '/update', (req, res)->
    MenuItemService.update(req, res)
