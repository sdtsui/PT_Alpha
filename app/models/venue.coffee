mongoose = require 'mongoose'
Schema   = mongoose.Schema

VenueSchema = new Schema(
  name:
    type: String
    required: true

  address:
    type: String
    required: true

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
