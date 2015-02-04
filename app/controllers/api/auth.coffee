express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
User  = mongoose.model 'User'
utils = require('../../../libs/utils')
# login = (req, res)->
#   console.log 'login......'
#   console.log req.user
#   redirectTo = 
#     if req.session.returnTo 
#       req.session.returnTo 
#     else
#       '/'
#   delete req.session.returnTo
#   res.redirect(redirectTo)

# signin = (req, res)->
#   console.log 'signin................'
#   console.log req

module.exports = (app, passport) ->
  app.use '/api/auth', router

  router.get '/logout', (req, res)->
    req.logout()
    res.redirect('/')

  router.post '/signup', (req, res)->
    user = new User(req.body)
    user.provider = 'local'
    user.save (err, u)->
      console.log 'save.............'
      console.log JSON.stringify(err)
      console.log err
      console.log u
      if err
        json = user.toJSON()
        json.errors = err.errors
        return res.json json

      res.json(user.toJSON())