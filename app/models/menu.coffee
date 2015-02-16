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

  pricePerHead:
    type: Number

  productType:
    type: String

  
)


mongoose.model 'Menu', MenuSchema
