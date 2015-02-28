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
      bucket: process.env.S3_BUCKET
      secretKey: process.env.AWS_SECRET_ACCESS_KEY
      accessId: process.env.AWS_ACCESS_KEY_ID

  development: require('./env/development')
  test: require('./env/test')
  production: require('./env/production')

module.exports = extend(config.defaults, config[env])
