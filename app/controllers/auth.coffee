express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
User  = mongoose.model 'User'

login = (req, res)->
  console.log 'login......'
  console.log req
  redirectTo = 
    if req.session.returnTo 
      req.session.returnTo 
    else
      '/'
  delete req.session.returnTo
  res.redirect(redirectTo)

signin = (req, res)->
  console.log 'signin................'
  console.log req

module.exports = (app, passport) ->
  app.use '/auth', router

  router.get '/', (req, res, next) ->

    res.render 'index',
      title: 'HandleRoR MVC'


  router.get '/facebook',
    passport.authenticate 'facebook',
      scope: [ 'email', 'user_about_me']
      failureRedirect: '/login'
  , signin

  router.get '/facebook/callback',
    passport.authenticate 'facebook', failureRedirect: '/login'
  , login
