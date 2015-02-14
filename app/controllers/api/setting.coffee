express  = require 'express'
router = express.Router()
api = require('../../../libs/authentication')
SettingService = require('../../services/setting_service')

module.exports = (app, passport) ->
  app.use '/api/settings', api.requiresLogin, router


  router.get "/", (req, res)->
    SettingService.getSetting(req, res)

  router.put "/", (req, res)->
    SettingService.updateSetting(req, res)


  