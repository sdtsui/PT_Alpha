mongoose = require 'mongoose'
_ = require('lodash')
Schema   = mongoose.Schema
ObjectId = Schema.ObjectId


ImageSchema = new Schema(
  venue: 
    type: ObjectId
    ref: 'Venue'
    required: true
    index: true

  fileName:
    type: String
    required: true

  fileType:
    type: String

  fileSize:
    type: Number

  filePath:
    type: String

  tags:
    type: [String] 
)


mongoose.model 'Image', ImageSchema
