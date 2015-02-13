express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
User  = mongoose.model 'User'
USER_CONFIG = require('../../models/user')
extend = require('util')._extend
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
    role.provider = USER_CONFIG.PROVIDERS.ROLE
    role.venue = req.user.venue
    role.save (e)->
      if e
        console.log e
        return res.status(400).send({message: e})

      res.json(role.toJSON())

  router.put '/:id', (req, res)->
    delete req.body.venue

    cond = 
      provider: USER_CONFIG.PROVIDERS.ROLE
      venue: req.user.venue
      id: req.query('id')

    User.findOne cond, (e, role)->
      if e || !role
        return res.status(400).send({message: 'not found'})

      role = extend(role, req.body)
      role.save (err)->
        if err
          return res.status(400).send({message: err})

        obj = role.toJSON()
        delete obj.hashPassword
        #
        res.json(obj)
