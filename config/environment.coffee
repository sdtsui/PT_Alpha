path     = require 'path'
rootPath = path.normalize __dirname + '/..'
extend = require('util')._extend
env      = process.env.NODE_ENV || 'development'

envDevelopment = {}
if env == 'development'
  envDevelopment = require('./env/development')
if env == 'test'
  envTest = require('./env/test')
if env == 'production'
  envProduction = require('./env/production')

config =
  defaults:
    root: rootPath
    app:
      name: 'privatetable'
    port: 3000
    db: process.env.MONGOLAB_URI || 'mongodb://localhost/pt_dev'
    AWS:
      bucket: process.env.S3_BUCKET
      secretKey: process.env.S3_ACCESS_KEY
      accessId: process.env.S3_ACCESS_KEY_ID

  development: envDevelopment
  test: envTest
  production: envProduction

module.exports = extend(config.defaults, config[env])
