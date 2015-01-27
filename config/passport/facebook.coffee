mongoose = require('mongoose')
FacebookStrategy = require('passport-facebook').Strategy
config = require('../environment')
User = mongoose.model('User')



facebook = new FacebookStrategy(
    clientID: config.facebook.clientID
    clientSecret: config.facebook.clientSecret
    callbackURL: config.facebook.callbackURL
  , (accessToken, refreshToken, profile, done)->
    options =
      criteria: { 'facebook.id': profile.id }

    User.load options, (err, user)->
      if (err) 
        return done(err)
      if !user
        user = new User
          name: profile.displayName
          email: profile.emails[0].value
          username: profile.username
          provider: 'facebook',
          facebook: profile._json
        
        user.save (err)->
          if (err) 
            console.log(err);
          return done(err, user)

      else
        return done(err, user)
)

module.exports = facebook