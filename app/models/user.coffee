bcrypt = require('bcrypt')

mongoose = require 'mongoose'
Schema   = mongoose.Schema

UserSchema = new Schema(
  name:
    type: String
    required: true

  company:
    type: String

  jobTitle:
    type: String

  avatar:
    type: String

  email:
    type: String
    required: true

  mobile:
    type: String

  address:
    type: String

)

mongoose.model 'User', UserSchema
