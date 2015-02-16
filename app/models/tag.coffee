mongoose = require 'mongoose'
_ = require('lodash')
Schema   = mongoose.Schema
ObjectId = Schema.ObjectId

KINDS =
  ROOM: 'roomType'
  COURSE: 'courseType'
  JOB_ROLE: 'jobRoleType'
  AMMENITY: 'ammenityType'

TagSchema = new Schema(
  kind:
    type: String
    required: true
    index: true

  name:
    type: String
    required: true

)

mongoose.model 'Tag', TagSchema


TagSchema.path('name').validate( (name, fn)->
  Tag = mongoose.model('Tag')
  that = this
  if !that.name
    that.invalidate('name', 'cannot be blank')
    return fn(true)
  regx = new RegExp('^'+that.name+'$', 'i')
  Tag.count({name: regx, kind: that.kind}).exec( (e, num)->
    if num && num > 0
      that.invalidate('name', 'is already existed')
  )
  return fn(true)

, null )



