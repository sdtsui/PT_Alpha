express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
User  = mongoose.model 'User'
Service = mongoose.model 'Service'
extend = require('util')._extend
utils = require('../../../libs/utils')
api = require('../../../libs/authentication')
module.exports = (app, passport) ->
  app.use '/api/services', api.requiresLogin, router

  router.get '/', (req, resp)->
    user = req.user
    Service.find {venue: user.venue}, (e, services)->
      if e
        return res.status(400).send({message: e})

      res.json(services)

  router.post '/', (req, res)->
    delete req.body.venue
    service = new Service(req.body)
    service.save (e)->
      if e
        return res.status(400).send({message: e})

      res.json(service.toJSON())
