extend = require('util')._extend

mongoose = require 'mongoose'
Setting = mongoose.model 'Setting'
Terminology = mongoose.model 'Terminology'
TagService = require('./tag_service')

exports.search = (req, res)->
  name = req.query.name || ''
  kind = req.query.kind || 'jobRoleType'
  limit = req.query.limit ||= 20

  TagService.search {name: name, taggable: kind, limit: limit}, (tags)->
    res.json(tags)

exports.removeFromVenue = (req, res)->
  cond = 
    venue: req.user.venue

  Setting.findOne cond, (e, setting)->
    if e
      return res.status(400).send({message: e})

    if !setting
      setting = new Setting()
      setting.venue = req.user.venue

    types = setting[req.body.kind] || []

    existed = types.indexOf(req.body.name)
    if existed >= 0
      types.splice(existed, 1)

    setting[req.body.kind] = types
    setting.save (err)->
      if err
        return res.status(400).send({message: err})

      TagService.addNew({name: req.body.name, taggable: req.body.kind})
      res.json(setting.toJSON())

exports.addToVenue = (req, res)->
  cond = 
    venue: req.user.venue

  Setting.findOne cond, (e, setting)->
    if e
      return res.status(400).send({message: e})

    if !setting
      setting = new Setting()
      setting.venue = req.user.venue

    types = setting[req.body.kind] || []

    if types.indexOf(req.body.name) < 0
      types.push req.body.name

    setting[req.body.kind] = types
    setting.save (err)->
      if err
        return res.status(400).send({message: err})

      TagService.addNew({name: req.body.name, taggable: req.body.kind})
      res.json(setting.toJSON())

