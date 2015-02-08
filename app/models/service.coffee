mongoose = require 'mongoose'
_ = require('lodash')
Schema   = mongoose.Schema
ObjectId = Schema.ObjectId

UNIT_METHODS =
  HEAD: '$ per guest'
  ITEM: '$ per item'
  EVENT: '$ per event'
  TIME: '$ per hour'
  OVER_TIME: '$ per hour over'
  DOZEN: '$ per 12 items'

ServiceSchema = new Schema(
  venue: 
    type: ObjectId
    ref: 'Venue'
    required: true
    index: true

  name:
    type: String
    required: true

  description:
    type: String

  unitMethod:
    type: String
    enum: _.keys(UNIT_METHODS)
    default: 'HEAD'

  unitRate:
    type: Number

  isActive:
    type: Boolean
    default: true

)


mongoose.model 'Service', ServiceSchema
