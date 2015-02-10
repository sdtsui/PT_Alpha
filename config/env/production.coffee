module.exports =
  app:
    name: 'PT_PROD'
  db: process.env.MONGOLAB_URI || 'mongodb://localhost/pt_dev'

  facebook:
    clientID: process.env.clientID || '1410645245825135'
    clientSecret: process.env.clientSecret || 'a04206a380afd10288afefa381cf4114'
    callbackURL: "http://localhost:3000/auth/facebook/callback"
  