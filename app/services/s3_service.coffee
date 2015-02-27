crypto = require('crypto')
moment = require('moment')

config = require('../../config/environment')

exports.getS3Policy = (req, res) ->
  expiration = moment().add('hours', 24).toDate()

  policy =
    'expiration': expiration
    'conditions': [
      {'bucket': config.AWS.bucket}
      ['starts-with', '$key', 'aaaaa' + '/']
      {'acl': 'public-read'}
      {'success_action_status': '201'}
      ['starts-with', '$Content-Type', '']
      ['content-length-range', 0, 5242880]
    ]

  policy_document = new Buffer(JSON.stringify(policy)).toString('base64')

  hmac = crypto.createHmac('sha1', config.AWS.secretKey)
  hmac.update(policy_document)

  signature = hmac.digest('base64')

  pl = 
    policy: policy_document
    signature: signature
    expiration: expiration
    accessId: config.AWS.accessId
  res.json(pl)