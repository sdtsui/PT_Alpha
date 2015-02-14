mongoose = require 'mongoose'
_ = require('lodash')
Schema   = mongoose.Schema
ObjectId = Schema.ObjectId

KINDS =
  ROOM: 'ROOM'
  COURSE: 'COURSE'
  JOB_ROLE: 'JOB_ROLE'
  AMMENITY: 'AMMENITY'

TerminologySchema = new Schema(
  kind:
    type: String
    required: true
    enum: _.values(TYPES)
    index: true

  name:
    type: String
    required: true
    unique: true

)

mongoose.model 'Terminology', TerminologySchema
