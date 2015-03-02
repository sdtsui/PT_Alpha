extend = require('util')._extend

mongoose = require 'mongoose'
MenuCourse = mongoose.model 'MenuCourse'

exports.all = (req, res)->
  MenuCourse.find({venue: req.user.venue}).exec (e, courses)->
    if e
      return res.status(400).send({message: e})

    res.json(courses)


exports.add = (req, res)->
  delete  req.body.venue
  delete req.body._id
  course = new MenuCourse(req.body)
  course.venue = req.user.venue

  course.save (err)->
    if err
      return res.status(400).send({message: err})

    res.json(course)

exports.update = (req, res)->
  cond = 
    venue: req.user.venue
    _id: req.body._id
  MenuCourse.findOne cond, (e, course)->
    delete  req.body.venue
    delete req.body._id
    course = extend(course, req.body)

    course.save (e)->
      if e
        return res.status(400).send({message: e.errors})

      res.json(course.toJSON())    
