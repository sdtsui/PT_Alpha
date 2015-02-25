extend = require('util')._extend

mongoose = require 'mongoose'
Tag = mongoose.model 'Tag'

exports.addNew = (options)->
  if !options.name || !options.taggable
    return false

  tag = new Tag({name: options.name, taggable: options.taggable})
  tag.save (err)->
    console.log 'xxxxxxxxxxaaaa'
    console.log err
  console.log 'xxxxxxx'
  return true

exports.search = (options, cb)->
  if !options.name || !options.taggable
    return cb([])

  options.limit ||= 20
  regx = new RegExp('^'+options.name, 'i')
  Tag.find({name: regx, taggable: options.taggable}).limit(options.limit).exec (e, tags)->
    if e
      return cb([])

    cb(tags)