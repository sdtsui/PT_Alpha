express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
User  = mongoose.model 'User'
Venue = mongoose.model 'Venue'
utils = require('../../../libs/utils')
api = require('../../../libs/authentication')

module.exports = (app, passport) ->
  app.use '/api/users', api.requiresLogin, router


  router.get "/me", (req, res)->
    user = req.user
    User.findOne user.id, (e, usr)->
      if e || !usr
        return res.status(401).send({message: "Unauthorized"})

      res.send(usr.toJSON())

  router.get '/roles', (req, res)->
    user = req.user
    cond = 
      venue: user.venue
      _id: {$ne: user._id}

    User.find cond, 'name email role phone notification', (e, roles)->
      if e
        return res.status(400).send({message: e})

      res.json(roles)


  router.post '/roles/create', (req, res)->
    delete req.body.venue
    role = new User(req.body)
    role.venue = req.user.venue
    role.save()