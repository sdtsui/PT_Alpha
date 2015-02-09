express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
User  = mongoose.model 'User'
Venue = mongoose.model 'Venue'
extend = require('util')._extend
utils = require('../../../libs/utils')
api = require('../../../libs/authentication')
module.exports = (app, passport) ->
  app.use '/api/venues', api.requiresLogin, router


  router.get "/mine", (req, res)->
    Venue.findOne {creator: req.user.id}, (e, venue)->
      if e || !venue
        return res.status(400).send({message: 'Not found venue'})
      json = venue.toJSON()
      delete json.creator
      res.json(json)

  router.put "/mine", (req, res)->
    Venue.findOne {_id: req.body._id}, (e, venue)->
      if e || !venue
        return res.status(400).json({message: "Not found venue"})

      delete req.body._id
      delete req.body.creator
      venue = extend(venue, req.body)
      venue.save()

      res.json(venue.toJSON())

  router.get '/settings', (req, res)->
    Venue.findOne {_id: req.user.venue}, 'settings', (e, venue)->
      if e || !venue
        return res.status(400).send({message: 'Not found venue'})

      settings = venue.settings || {introEmail: '', marketIntro: '', emailSuccess: ''}

      res.json(settings)
  
  router.put '/settings', (req, res)->
    Venue.findOne {_id: req.user.venue}, (e, venue)->
      if e || !venue
        return res.status(400).send({message: 'Not found venue'})


      venue = extend(venue, {settings: req.body.settings})
      venue.save()
      console.log venue
      res.json(req.body)

