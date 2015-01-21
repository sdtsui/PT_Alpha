path     = require 'path'
rootPath = path.normalize __dirname + '/..'
env      = process.env.NODE_ENV || 'development'

config =
  development:
    root: rootPath
    app:
      name: 'privatetable'
    port: 3000
    db: 'mongodb://localhost/pt_dev'

  test:
    root: rootPath
    app:
      name: 'privatetable'
    port: 3000
    db: 'mongodb://localhost/privatetable-test'

  production:
    root: rootPath
    app:
      name: 'privatetable'
    port: 3000
    db: 'mongodb://localhost/privatetable-production'

module.exports = config[env]
