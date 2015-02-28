mongoose = require 'mongoose'
_ = require('lodash')
Schema   = mongoose.Schema
ObjectId = Schema.ObjectId


MenuSchema = new Schema(
  venue: 
    type: ObjectId
    ref: 'Venue'
    required: true
    index: true

  name:
    type: String
    required: true

  price:
    value:
      type: Number
    unit:
      type: String

  productType:
    type: String

  
)


mongoose.model 'Menu', MenuSchema
