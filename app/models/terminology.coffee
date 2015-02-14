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
    enum: _.values(KINDS)
    index: true

  name:
    type: String
    required: true

)

mongoose.model 'Terminology', TerminologySchema


TerminologySchema.path('name').validate( (name, fn)->
  Terminology = mongoose.model('Terminology')
  that = this
  if !that.name
    that.invalidate('name', 'cannot be blank')
    return fn(true)
  regx = new RegExp('^'+that.name+'$', 'i')
  Terminology.count({name: regx, kind: options.kind}).exec (e, num)->
    if num && num > 0
      that.invalidate('name', 'is already existed')
    return fn(true)

, null )


TerminologySchema.statics = 
  store: (options, cb)->
    this.insert({name: options.name, kind: options.kind}).exec(cb)

  search: (options, cb)->
    options.name ||= ''
    options.limit ||= 20
    regx = new RegExp('^'+options.name, 'i')
    this.find(name: regx, kind: options.kind).limit(options.limit).exec(cb)
