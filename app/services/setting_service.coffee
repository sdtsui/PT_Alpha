extend = require('util')._extend

mongoose = require 'mongoose'
Setting = mongoose.model 'Setting'

exports.updateSetting = (req, res)->
  user = req.user
  cond = 
    venue: req.user.venue
  Setting.findOne cond, (e, setting)->
    if e
      return res.status(401).send({message: e})
    delete req.body._id
    if setting
      setting = extend(setting, req.body)
    else
      setting = new Setting(req.body)
      setting.venue = req.user.venue
    console.log setting.toJSON()
    setting.save (err)->
      if err
        return res.status(400).send({message: err})
      res.send(setting.toJSON())


exports.getSetting = (req, res)->
  cond = 
    venue: req.user.venue
  Setting.findOne cond, (e, setting)->
    if e
      return res.status(401).send({message: e})
    if !setting
      setting = new Setting()
    res.send(setting.toJSON())

