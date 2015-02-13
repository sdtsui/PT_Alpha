express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
User  = mongoose.model 'User'
Venue = mongoose.model 'Venue'
USER_CONFIG = require('../../models/user')
utils = require('../../../libs/utils')

module.exports = (app, passport) ->
  app.use '/api/auth', router

  router.get '/logout', (req, res)->
    console.log 'aaa logout'
    req.logout()
    res.redirect('/')

  router.post '/signup', (req, res)->
    console.log req.body
    user = new User(req.body)
    user.provider = USER_CONFIG.PROVIDERS.LOCAL
    user.save (err)->
      if err
        json = user.toJSON()
        json.errors = err.errors
        return res.json json
      
      venue = new Venue(
        email: user.email
        creator: user._id
        name: user.venueName
        url: utils.getFormatedUrl(user.venueUrl)
      )
      venue.save (e)->
        if !e
          user.venue = venue._id
          user.save()
      req.logIn user, (err)->
        if err
          json = user.toJSON()
          json.errors = 'Sorry! We are not able to log you in!'
          return res.json(json)
        res.json(user.toJSON())

  router.post '/login', (req, res)->
    passport.authenticate( USER_CONFIG.PROVIDERS.LOCAL, (err, user, info)->
      if err || !user
        return res.json({errors: "Email or password is not valid"})

      req.logIn user, (err)->
        if err
          return res.json({errors: "Email or password is not valid"})
        return res.json(user.toJSON())
    )(req, res)
