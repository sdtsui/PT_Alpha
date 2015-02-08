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

  router.get '/', (req, res)->
    user = req.user
    Service.find {venue: user.venue}, (e, services)->
      if e
        return res.status(400).send({message: e})

      res.json(services)

  router.post '/create', (req, res)->
    delete req.body.venue
    service = new Service(req.body)
    service.venue = req.user.venue
    service.save (e)->
      if e
        return res.status(400).send({message: e.errors})

      res.json(service.toJSON())

  router.put '/update', (req, res)->

    Service.findOne {_id: req.body._id, venue: req.user.venue}, (e, service)->
      if e || !service
        return res.status(400).send({message: "Not found service."})
  
      delete req.body._id
      delete req.body.venue

      service = extend(service, req.body)

      service.save (e)->
        if e
          return res.status(400).send({message: e.errors})

        res.json(service.toJSON())

  router.delete '/:id', (req, res)->

    Service.remove {_id: req.param('id'), venue: req.user.venue}, (e, service)->
      if e || !service
        return res.status(400).send({message: "Not found service."})

      res.json({message: 'ok'})
