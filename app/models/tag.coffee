mongoose = require 'mongoose'
_ = require('lodash')
Schema   = mongoose.Schema
ObjectId = Schema.ObjectId

TAGGABLES =
  ROOM_TYPE: 'roomType'
  COURSE_TYPE: 'courseType'
  JOB_ROLE_TYPE: 'jobRoleType'
  AMMENITY: 'ammenityType'

TagSchema = new Schema(
  taggable:
    type: String
    required: true
    index: true

  name:
    type: String
    required: true
    index: true

)

mongoose.model 'Tag', TagSchema


TagSchema.path('name').validate( (name, fn)->
  Tag = mongoose.model('Tag')
  that = this
  if !that.name
    that.invalidate('name', 'cannot be blank')
    return fn(true)
  regx = new RegExp('^'+that.name+'$', 'i')
  Tag.count({name: regx, taggable: that.taggable}).exec( (e, num)->
    if num && num > 0
      that.invalidate('name', 'is already existed')
  )
  return fn(true)

, null )



