extend = require('util')._extend

mongoose = require 'mongoose'
MenuItem = mongoose.model 'MenuItem'

exports.all = (req, res)->
  MenuItem.find({venue: req.user.venue}).exec (e, items)->
    if e
      return res.status(400).send({message: e})

    res.json(items)


exports.add = (req, res)->
  delete  req.body.venue
  delete req.body._id
  item = new MenuItem(req.body)
  item.venue = req.user.venue

  item.save (err)->
    if err
      return res.status(400).send({message: err})

    res.json(item)

exports.update = (req, res)->
  delete  req.body.venue
  delete req.body._id
  item = new MenuItem(req.body)
  item.venue = req.user.venue

  item.save (err)->
    if err
      return res.status(400).send({message: err})

    res.json(item)

