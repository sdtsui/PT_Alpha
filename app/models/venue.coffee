mongoose = require 'mongoose'
Schema   = mongoose.Schema
ObjectId = Schema.ObjectId

VenueSchema = new Schema(
  creator: 
    type: ObjectId
    ref: 'User'
    required: true
    index: true
    
  name:
    type: String
    required: true

  address:
    type: String
    # required: true

  phone:
    type: String

  fax:
    type: String

  url:
    type: String

  email:
    type: String

  taxInMenu:
    type: Boolean
    defaults: true

  tax:
    type: Number

  gratuity:
    type: Number

  businessHour:
    openTime: Number
    closeTime: Number

  timeZone:
    type: String
    # enum

  cuisineType:
    type: String

  currency:
    type: String
    # enum:

  settings:
    introEmail: String
    marketIntro: String
    emailSuccess: String
  
)

mongoose.model 'Venue', VenueSchema
