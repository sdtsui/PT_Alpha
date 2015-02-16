mongoose = require 'mongoose'
_ = require('lodash')
Schema   = mongoose.Schema
ObjectId = Schema.ObjectId


MenuItemSchema = new Schema(
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


  subcategory:
    type: String

  price:
    value: Number
    unit: String

  guest:
    countRequired: Boolean
    countValue: Number

  ingredients:
    type: Array

  preferences:
    type: Array


  isActive:
    type: Boolean
    default: true

  
)


mongoose.model 'MenuItem', MenuItemSchema
