express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
User  = mongoose.model 'User'
utils = require('../../../libs/utils')
api = require('../../../libs/authentication')

module.exports = (app, passport) ->
  app.use '/api/roles', api.requiresLogin, router



  router.get '/', (req, res)->
    user = req.user
    cond = 
      venue: user.venue
      _id: {$ne: user._id}

    User.find cond, 'name email role phone notification', (e, roles)->
      if e
        return res.status(400).send({message: e})

      res.json(roles)


  router.post '/', (req, res)->
    delete req.body.venue
    role = new User(req.body)
    role.venue = req.user.venue
    role.save (e)->
      if e
        console.log e
        return res.status(400).send({message: e})

      res.json(role.toJSON())
