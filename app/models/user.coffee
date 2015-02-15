_ = require('lodash')
crypto = require('crypto')

mongoose = require 'mongoose'
Schema   = mongoose.Schema
ObjectId = Schema.ObjectId

PROVIDERS =
  FACEBOOK: 'facebook'
  LOCAL: 'local'


UserSchema = new Schema(
  venue: 
    type: ObjectId
    ref: 'Venue'

  # auth attributes
  email:
    type: String
    # required: true

  hashedPassword:
    type: String
    default: ''

  salt:
    type: String
    default: ''

  provider:
    type: String
    enum: _.values(PROVIDERS)
    required: true

  isOwner:
    type: Boolean
    default: true

  confirmationToken:
    type: String

  resetPasswordToken:
    type: String

  facebook: {}
  
  role:
    type: String

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

  phone:
    type: String

  address:
    type: String

  isActive:
    type: Boolean
    default: true
  notifications:
    abandonCart:
      email:
        type: Boolean
        default: true
      phone:
        type: Boolean
        default: true
    newEvent:
      email:
        type: Boolean
        default: true
      phone:
        type: Boolean
        default: true
    newMessage:
      email:
        type: Boolean
        default: true
      phone:
        type: Boolean
        default: true
    newProspect:
      email:
        type: Boolean
        default: true
      phone:
        type: Boolean
        default: true

)

UserSchema.virtual('password')
.set (password)->
  this._password = password
  this.salt = this.makeSalt()
  this.hashedPassword = this.encryptPassword(password)
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


UserSchema.path('name').validate( (name)->
  if this.skipPassword()
    return true
  return name.length
, 'Name cannot be blank')

UserSchema.path('email').validate( (email)->
  if this.skipPassword()
    return true
  return email.length
, 'Email cannot be blank')

UserSchema.path('email').validate( (email, fn)->
  User = mongoose.model('User')
  if this.skipPassword()
    fn(true)

  if (this.isNew || this.isModified('email'))
    User.count({ email: email, provider: PROVIDERS.LOCAL}).exec( (err, users)->
      console.log users
      fn(!err && users == 0)
    )
  else 
    fn(true)
, 'Email already exists')

# validate venueName
UserSchema.path('name').validate( (name, fn)->
  that = this
  Venue = mongoose.model('Venue')
  if this.skipPassword() || this.skipSignup()
    return fn(true)

  if that.isNew
    if !that._venueName
      that.invalidate('venueName', 'can not be blank')
      return fn(true)
    if that._venueName.length < 3
      that.invalidate('venueName', 'must greater 3 chars')
      return fn(true)
    if that._venueName
      Venue.count({ name: that._venueName }).exec( (err, num)->
        if err || (num && num > 0)
          that.invalidate('venueName', 'is already existed')
      )

  fn(true)
, null)

# validate venueUrl
UserSchema.path('name').validate( (name, fn)->
  that = this
  regx = /(http(s?)\:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}((\S)*)$/i
  Venue = mongoose.model('Venue')
  if this.skipPassword() || this.skipSignup()
    return fn(true)

  if that.isNew
    if !that._venueUrl
      return fn(true)
    url = that._venueUrl.match(regx)
    if !url
      that.invalidate('venueUrl', 'is invalid')
      return fn(true)
    url = url[0].toLowerCase()
    Venue.count({ url: url}).exec( (err, num)->
      if err || (num && num > 0)
        that.invalidate('venueUrl', 'is already existed')
    )

  fn(true)
, null)



UserSchema.path('hashedPassword').validate( (hashedPassword, fn)->
  that = this
  if this.skipPassword()
    return fn(true)
  if !that._password
    that.invalidate('password', 'can not be blank')
    return fn(true)
  if that._password.length < 6
    that.invalidate('password', 'must be longer')
  return fn(true)
, null)


UserSchema.methods = 
  authenticate: (plainText)->
    return this.encryptPassword(plainText) == this.hashedPassword


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


  skipPassword: ()->
    return !this.isNew || this.provider != PROVIDERS.LOCAL

  skipSignup: ()->
    return !this.isOwner

  toJSON: ()->
    obj = this.toObject()
    delete obj.hashedPassword
    delete obj.salt
    delete obj.provider
    delete obj.isOwner
    delete obj.confirmationToken
    delete obj.resetPasswordToken
    delete obj.facebook
    obj

  roleJSON: ()->
    obj = this.toJSON()
    delete obj.hashedPassword
    delete obj.salt
    delete obj.provider
    delete obj.isOwner
    delete obj.confirmationToken
    delete obj.resetPasswordToken
    delete obj.facebook
    obj

UserSchema.statics =
  load: (options, cb)->
    options.select = options.select || 'venue name email'
    this.findOne(options.criteria).select(options.select).exec(cb)

mongoose.model 'User', UserSchema

module.exports = 
  PROVIDERS: PROVIDERS
