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
