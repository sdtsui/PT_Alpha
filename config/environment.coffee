path     = require 'path'
rootPath = path.normalize __dirname + '/..'
extend = require('util')._extend
env      = process.env.NODE_ENV || 'development'

config =
  defaults:
    root: rootPath
    app:
      name: 'privatetable'
    port: 3000
    db: process.env.MONGOLAB_URI || 'mongodb://localhost/pt_dev'
    AWS:
      secretKey: ''
      accessId: ''
      
  development: require('./env/development')
  test: require('./env/test')
  production: require('./env/production')

module.exports = extend(config[env], config.defaults)
