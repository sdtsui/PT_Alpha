express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
User  = mongoose.model 'User'
Setting = mongoose.model 'Setting'
extend = require('util')._extend
utils = require('../../../libs/utils')
api = require('../../../libs/authentication')

module.exports = (app, passport) ->
  app.use '/api/settings', api.requiresLogin, router


  router.get "/", (req, res)->
    cond = 
      venue: req.user.venue
    Setting.findOne cond, (e, setting)->
      if e
        return res.status(401).send({message: e})
      if !setting
        setting = new Setting()
      res.send(setting.toJSON())

  router.put "/", (req, res)->
    user = req.user
    cond = 
      venue: req.user.venue
    Setting.findOne cond, (e, setting)->
      if e
        return res.status(401).send({message: e})
      delete req.body._id
      console.log req.body
      if setting
        setting = extend(setting, req.body)
      else
        setting = new Setting(req.body)
        setting.venue = req.user.venue
      console.log setting.toJSON()
      setting.save (err)->
        if err
          return res.status(400).send({message: err})
        res.send(setting.toJSON())
