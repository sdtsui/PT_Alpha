express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
User  = mongoose.model 'User'
utils = require('../../../libs/utils')

module.exports = (app, passport) ->
  app.use '/api/auth', router

  router.get '/logout', (req, res)->
    req.logout()
    res.redirect('/')

  router.post '/signup', (req, res)->
    user = new User(req.body)
    user.provider = 'local'
    user.save (err)->
      console.log 'save.............'
      if err
        json = user.toJSON()
        json.errors = err.errors
        return res.json json
      
      req.logIn user, (err)->
        if err
          json = user.toJSON()
          json.errors = 'Sorry! We are not able to log you in!'
          return res.json(json)
        res.json(user.toJSON())