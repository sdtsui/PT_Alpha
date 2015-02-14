express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
User  = mongoose.model 'User'
USER_CONFIG = require('../../models/user')
extend = require('util')._extend
utils = require('../../../libs/utils')
api = require('../../../libs/authentication')
crypto = require('crypto')

module.exports = (app, passport) ->
  app.use '/api/roles', api.requiresLogin, router



  router.get '/', (req, res)->
    user = req.user
    cond = 
      venue: user.venue
      _id: {$ne: user._id}

    User.find cond, 'name email role phone notifications', (e, roles)->
      if e
        return res.status(400).send({message: e})

      res.json(roles)


  router.post '/', (req, res)->
    delete req.body.venue
    role = new User(req.body)
    role.provider = USER_CONFIG.PROVIDERS.LOCAL
    role.venue = req.user.venue
    role.password = utils.randomKey()
    role.isOwner = false
    role.save (e)->
      if e
        console.log e
        return res.status(400).send({message: e})

      res.json(role.roleJSON())

  router.put '/update', (req, res)->
    cond = 
      provider: USER_CONFIG.PROVIDERS.LOCAL
      venue: req.user.venue
      _id: req.body._id
    User.findOne cond, (e, role)->
      if e || !role
        return res.status(400).send({message: 'not found'})

      delete req.body.venue
      delete req.body._id
      role = extend(role, req.body)
      role.save (err)->
        if err
          return res.status(400).send({message: err})

        obj = role.roleJSON()
        #
        res.json(obj)
