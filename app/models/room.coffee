mongoose = require 'mongoose'
_ = require('lodash')
Schema   = mongoose.Schema
ObjectId = Schema.ObjectId


RoomSchema = new Schema(
  venue: 
    type: ObjectId
    ref: 'Venue'
    required: true
    index: true
    
  name:
    type: String
    required: true
  roomType:
    type: String
    required: true

  roomSize:
    value: Number
    unit: String

  description:
    type: String

  isActive:
    type: Boolean
    default: true

  requireApproval:
    type: Boolean
    default: true

  revenueOn:
    type: Boolean
    default: true

  rate:
    day: Number
    night: Number

  fee:
    rental: Number
    cleaning: Number

  overage:
    value: Number
    unit: String

  houseRule:
    type: String

  cancelPolicy:
    type: String

  leadTime:
    type: String
  
  # marketing tags
  marketing:
    type: Array

  amenities:
    type: Array

  services:
    type: Array

  menus:
    type: Array

)


mongoose.model 'Room', RoomSchema
