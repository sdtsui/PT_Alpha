extend = require('util')._extend

mongoose = require 'mongoose'
Room = mongoose.model 'Room'
RoomLayout = mongoose.model 'RoomLayout'


exports.getAll = (req, res)->
  Room.find({venue: req.user.venue}).exec (e, rooms)->
    if e 
      return res.status(400).send({message: e})
    res.json(rooms)


exports.add = (req, res)->
  delete req.body._id
  delete req.body.venue
  room = new Room(req.body)
  room.venue = req.user.venue
  room.save (err)->
    if err
      return res.status(400).send({message: err})

    res.json(room)


exports.update = (req, res)->

  cond = 
    venue: req.user.venue
    _id: req.body._id

  Room.findOne cond, (e, room)->
    if e || !room
      return res.status(400).send({message: 'not found room'})
    delete req.body._id
    delete req.body.venue

    room = extend(room, req.body)
    room.save (err)->
      if err
        return res.status(400).send({message: err})

      res.json(room)

exports.roomAuthorize = (req, res, next)->
  roomId = req.body.room || req.query.room
  if !roomId
    return res.status(400).send({message: 'not found room'})
  Room.findOne {venue: req.user.venue, _id: roomId}, (e, room)->
    if e
      return res.status(400).send({message: e})

    req.room = room
    return next()

exports.getLayouts = (req, res)->

  RoomLayout.find({room: req.room._id}).exec (e, layouts)->
    if e
      return res.status(400).send({message: e})

    res.json(layouts)

exports.addLayout = (req, res)->
  delete req.body._id
  delete req.body.room
  layout = new RoomLayout(req.body)
  layout.room = req.room.id
  layout.save (err)->
    if err
      return res.status(400).send({message: err})

    res.json(layout)

exports.updateLayout = (req, res)->
  cond = 
    room: req.room._id
    _id: req.body._id

  RoomLayout.findOne cond, (e, layout)->
    if e || !layout
      return res.status(400).send({message: 'not found layout'})

    delete req.body.room
    delete req.body._id
    layout = extend(layout, req.body)
    layout.save (err)->
      if err
        return res.status(400).send({message: err})
      res.json(layout)

exports.deleteLayout = (req, res)->
  cond = 
    room: req.room._id
    _id: req.body._id

  RoomLayout.remove cond, (e, layout)->
    if e || !layout
      return res.status(400).send({message: "Not found layout."})

    res.json({message: 'ok'})