mongoose = require 'mongoose'
_ = require('lodash')
Schema   = mongoose.Schema
ObjectId = Schema.ObjectId


MenuCourseSchema = new Schema(
  menu: 
    type: ObjectId
    ref: 'Menu'
    required: true
    index: true

  name:
    type: String
    required: true

  menuItems:
    type: Array
    default: []
  
  
)


mongoose.model 'MenuCourse', MenuCourseSchema
