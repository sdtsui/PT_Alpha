express = require 'express'
session = require('express-session')
glob = require 'glob'
cookieSession = require('cookie-session')
flash = require('connect-flash')
favicon = require 'serve-favicon'
logger = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
compress = require 'compression'
methodOverride = require 'method-override'

mongoStore = require('connect-mongo')(session)
pkg = require('../package.json')

module.exports = (app, config, passport) ->
  app.set 'views', config.root + '/app/views'
  app.set 'view engine', 'jade'

  # app.use(favicon(config.root + '/public/img/favicon.ico'));
  app.use logger 'dev'
  app.use bodyParser.json()
  app.use bodyParser.urlencoded(
    extended: true
  )
  app.use cookieParser()
  app.use compress()

  app.use(cookieSession({ secret: 'secretkey' }))
  app.use session(
    resave: true
    saveUninitialized: true
    secret: pkg.name
    store: new mongoStore(
      url: config.db
      collection : 'expresssessions'
    )
  )


  app.use express.static config.root + '/public'
  app.use methodOverride()

  app.use passport.initialize()
  app.use passport.session()


