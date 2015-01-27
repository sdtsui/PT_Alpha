mongoose = require('mongoose')
LocalStrategy = require('passport-local').Strategy
User = mongoose.model('User')
local = require('./passport/local')
facebook = require('./passport/facebook')


module.exports = (passport, config)->

  passport.serializeUser (user, done)->
    done(null, user.id)

  passport.deserializeUser (id, done)->
    User.load { criteria: { _id: id } },  (err, user)->
      done(err, user)

  passport.use(local)
  
  passport.use(facebook)

