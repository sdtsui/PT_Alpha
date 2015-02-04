_ = require('lodash')
crypto = require('crypto')

mongoose = require 'mongoose'
Schema   = mongoose.Schema

AUTH_TYPES = [
  'facebook'
  'local'
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

  facebook: {}
  
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

UserSchema.virtual('passwordConfirmation')
.set (passwordConfirmation)->
  this._passwordConfirmation = passwordConfirmation
.get ()->
  return this._passwordConfirmation


UserSchema.virtual('venueName')
.set (venueName)->
  this._venueName = venueName
.get ()->
  return this._venueName


UserSchema.virtual('venueUrl')
.set (venueUrl)->
  this._venueUrl = venueUrl
.get ()->
  return this._venueUrl



validatePresenceOf = (value)->
  return value && value.length

validateMatchPasswords = (value1, value2)->
  return value1 && value2 && value1 == value2

UserSchema.pre 'save', (next)->
  if !this.isNew 
    return next()

  if !validatePresenceOf(this.password) && !this.skipValidation()
    return next(new Error('Invalid password'))

  # if !validateMatchPasswords(this.password, this.passwordConfirmation) && !this.skipValidation()
  #   return next(new Error('Not matched password'))

  return next()


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
  console.log this.skipValidation()
  console.log this.isNew
  console.log this.isModified('email')
  if this.skipValidation()
    fn(true)

  if (this.isNew || this.isModified('email'))
    User.find({ email: email }).exec( (err, users)->
      console.log users
      fn(!err && users.length == 0)
    )
  else 
    fn(true)
, 'Email already exists')


# UserSchema.path('venueName').validate( (venueName, fn)->
#   Venue = mongoose.model('Venue')
#   if this.skipValidation()
#     fn(true)

#   if (this.isNew || this.isModified('venueName'))
#     Venue.count({ name: venueName }).exec( (err, num)->
#       fn(!err && num == 0)
#     )
#   else
#     fn(true)
# , 'Venue already exists')



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
    return this.provider != 'local'


UserSchema.statics =
  load: (options, cb)->
    options.select = options.select || 'name email'
    this.findOne(options.criteria).select(options.select).exec(cb)

mongoose.model 'User', UserSchema
