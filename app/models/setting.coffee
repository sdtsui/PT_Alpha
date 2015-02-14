mongoose = require 'mongoose'
_ = require('lodash')
Schema   = mongoose.Schema
ObjectId = Schema.ObjectId



SettingSchema = new Schema(
  venue: 
    type: ObjectId
    ref: 'Venue'
    required: true
    index: true

  # use for settings
  introEmail:
    type: String
  marketIntro:
    type: String
  emailSuccess:
    type: String

  # use for terminology
  roomType:
    type: Array

  courseType:
    type: Array

  jobRoleType:
    type: Array

  ammenityType:
    type: Array

)

mongoose.model 'Setting', SettingSchema
