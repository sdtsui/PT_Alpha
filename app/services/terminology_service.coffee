extend = require('util')._extend

mongoose = require 'mongoose'
Setting = mongoose.model 'Setting'
Terminology = mongoose.model 'Terminology'


exports.search = (req, res)->
  name = req.query.name || ''
  kind = req.query.kind || 'jobRoleType'
  limit = req.query.limit ||= 20
  regx = new RegExp('^'+name, 'i')
  Terminology.find({name: regx, kind: kind}).limit(limit).exec (e, terms)->
    if e
      return res.status(400).send({message: e})

    res.json(terms)



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

      res.json(setting.toJSON())
      