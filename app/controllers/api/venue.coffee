express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
User  = mongoose.model 'User'
Venue = mongoose.model 'Venue'
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