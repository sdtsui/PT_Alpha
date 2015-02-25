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

TagSchema.path('name').validate( (name, fn)->
  Tag = mongoose.model('Tag')
  if !this.isNew
    fn(true)

  if (this.isNew || this.isModified('name'))
    regx = new RegExp('^'+name+'$', 'i')
    Tag.count({ name: regx, taggable: this.taggable }).exec( (err, tags)->
      fn(!err && tags == 0)
    )
  else 
    fn(true)
, 'Name already exists')

# TagSchema.path('name').validate( (name, fn)->
#   that = this
#   Tag = mongoose.model('Tag')
#   if !name
#     that.invalidate('name', 'cannot be blank')
#     return fn(true)
#   if this.isNew  
#     regx = new RegExp('^'+name+'$', 'i')
#     console.log this
#     Tag.count({ name: regx}).exec( (e, tags)->
#       console.log tags
#       if tags && tags > 0
#         that.invalidate('name', 'is already existed')
#     )
#   fn(true)
# , null)


mongoose.model 'Tag', TagSchema


