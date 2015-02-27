crypto = require('crypto')
moment = require('moment')

config = require('../../config/environment')

exports.getS3Policy = (req, res) ->
  expiration = moment().add('hours', 24).toDate()
  console.log 'getS3Policy'
  console.log config
  policy =
    'expiration': expiration
    'conditions': [
      ["starts-with", "$utf8", ""]
      {'bucket': config.AWS.bucket}
      ["starts-with", "$key", ""]
      {'acl': 'private'}
      {'success_action_status': '201'}
      ['starts-with', '$Content-Type', '']
      ['content-length-range', 0, 5242880]
    ]

  policy_document = new Buffer(JSON.stringify(policy)).toString('base64')

  hmac = crypto.createHmac('sha1', config.AWS.secretKey)
  hmac.update(policy_document)

  signature = hmac.digest('base64')

  pl = 
    bucket: config.AWS.bucket
    policy: policy_document
    signature: signature
    expiration: expiration
    accessId: config.AWS.accessId
  res.json(pl)