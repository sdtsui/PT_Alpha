mongoose = require 'mongoose'
_ = require('lodash')
Schema   = mongoose.Schema
ObjectId = Schema.ObjectId


RoomLayoutSchema = new Schema(
  room: 
    type: ObjectId
    ref: 'Room'
    required: true
    index: true

  name:
    type: String
    required: true

  productType:
    type: String

  maxGuest:
    type: Number

  minHour:
    type: Number

  description: 
    type: String

  isActive:
    type: Boolean
    default: true
  
)


mongoose.model 'RoomLayout', RoomLayoutSchema