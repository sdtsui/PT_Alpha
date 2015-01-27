_ = require('lodash')
crypto = require('crypto')

mongoose = require 'mongoose'
Schema   = mongoose.Schema

AUTH_TYPES = [
  'facebook'
]

UserSchema = new Schema(
  # auth attributes
  email:
    type: String
    required: true

  hashed_password:
    type: String
    default: ''

  salt:
    type: String
    default: ''

  provider:
    type: String
    enum: AUTH_TYPES

  # profile attributes
  name:
    type: String
    required: true

  company:
    type: String

  jobTitle:
    type: String

  avatar:
    type: String

  mobile:
    type: String

  address:
    type: String

)

UserSchema.virtual('password')
.set (password)->
  this._password = password
  this.salt = this.makeSalt()
  this.hashed_password = this.encryptPassword(password)
.get ()->
  return this._password

validatePresenceOf = (value)->
  return value && value.length


UserSchema.pre 'save', (next)->
  if !this.isNew 
    return next()

  if !validatePresenceOf(this.password) && !this.skipValidation()
    next(new Error('Invalid password'))
  else
    next()


UserSchema.path('name').validate( (name)->
  if this.skipValidation()
    return true
  return name.length
, 'Name cannot be blank')

UserSchema.path('email').validate( (email)->
  if this.skipValidation()
    return true
  return email.length
, 'Email cannot be blank')

UserSchema.path('email').validate( (email, fn)->
  User = mongoose.model('User')
  if this.skipValidation()
    fn(true)

  if (this.isNew || this.isModified('email'))
    User.find({ email: email }).exec( (err, users)->
      fn(!err && users.length == 0)
    )
  else 
    fn(true)
, 'Email already exists')


UserSchema.path('hashed_password').validate( (hashed_password)->
  if this.skipValidation()
    return true
  return hashed_password.length
, 'Password cannot be blank')


UserSchema.methods = 
  authenticate: (plainText)->
    return this.encryptPassword(plainText) == this.hashed_password


  makeSalt: ()->
    return Math.round((new Date().valueOf() * Math.random())) + ''

  encryptPassword: (password)->
    if !password
      return ''
    try
      return crypto
        .createHmac('sha1', this.salt)
        .update(password)
        .digest('hex');
    catch err
      return ''


  skipValidation: ()->
    return ~AUTH_TYPES.indexOf(this.provider)


UserSchema.statics =
  load: (options, cb)->
    options.select = options.select || 'name email'
    this.findOne(options.criteria).select(options.select).exec(cb)

mongoose.model 'User', UserSchema
