mongoose = require 'mongoose'
_ = require('lodash')
Schema   = mongoose.Schema
ObjectId = Schema.ObjectId

KINDS =
  ROOM: 'roomType'
  COURSE: 'courseType'
  JOB_ROLE: 'jobRoleType'
  AMMENITY: 'ammenityType'

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
