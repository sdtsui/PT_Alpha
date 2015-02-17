extend = require('util')._extend

mongoose = require 'mongoose'
Tag = mongoose.model 'Tag'

exports.addNew = (options)->
  if !options.name || !options.kind
    return false
  tag = new Tag({name: options.name, kind: options.kind})
  tag.save()
  return true

exports.search = (options, cb)->
  if !options.name || !options.kind
    return cb([])

  options.limit ||= 20
  regx = new RegExp('^'+options.name, 'i')
  Tag.find({name: regx, kind: options.kind}).limit(options.limit).exec (e, tags)->
    if e
      return cb([])

    cb(tags)