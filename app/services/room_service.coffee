extend = require('util')._extend

mongoose = require 'mongoose'
Room = mongoose.model 'Room'


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


