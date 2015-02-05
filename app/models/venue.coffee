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

  timeZone:
    type: String
    # enum

  phone:
    type: String

  fax:
    type: String

  email:
    type: String

  url:
    type: String

  businessHour:
    openTime: String
    closeTime: String

  cuisineType:
    type: String

  tax:
    type: Number

  gratuity:
    type: Number

)

mongoose.model 'Venue', VenueSchema
