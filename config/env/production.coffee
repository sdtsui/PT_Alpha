module.exports =
  app:
    name: 'PT_PROD'
  db: process.env.MONGOLAB_URI || 'mongodb://localhost/pt_dev'
  AWS:
    bucket: process.env.S3_BUCKET
    secretKey: process.env.S3_ACCESS_KEY
    accessId: process.env.S3_ACCESS_KEY_ID
  
  facebook:
    clientID: process.env.clientID || '1410645245825135'
    clientSecret: process.env.clientSecret || 'a04206a380afd10288afefa381cf4114'
    callbackURL: "http://localhost:3000/auth/facebook/callback"
  