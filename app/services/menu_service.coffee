extend = require('util')._extend

mongoose = require 'mongoose'
Menu = mongoose.model 'Menu'

exports.all = (req, res)->
  Menu.find({venue: req.user.venue}).exec (e, menus)->
    if e
      return res.status(400).send({message: e})

    res.json(menus)


exports.add = (req, res)->
  delete  req.body.venue
  delete req.body._id
  menu = new Menu(req.body)
  menu.venue = req.user.venue

  menu.save (err)->
    if err
      return res.status(400).send({message: err})

    res.json(menu)

exports.update = (req, res)->
  cond = 
    venue: req.user.venue
    _id: req.body._id
  Menu.findOne cond, (e, menu)->
    delete  req.body.venue
    delete req.body._id
    menu = extend(menu, req.body)

    menu.save (e)->
      if e
        return res.status(400).send({message: e.errors})

      res.json(menu.toJSON())    
