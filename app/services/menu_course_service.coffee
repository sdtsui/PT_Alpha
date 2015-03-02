extend = require('util')._extend

mongoose = require 'mongoose'
Menu = mongoose.model 'Menu'
MenuCourse = mongoose.model 'MenuCourse'

exports.menuAuthorize = (req, res, next)->
  menuId = req.body.menu || req.query.menu
  if !menuId
    return res.status(400).send({message: 'not found menu'})
  cond = 
    venue: req.user.venue
    _id: menuId
  Menu.findOne cond, (e, menu)->
    if e
      return res.status(400).send({message: e})

    req.menu = menu
    return next()


exports.all = (req, res)->
  MenuCourse.find({menu: req.menu._id}).exec (e, courses)->
    if e
      return res.status(400).send({message: e})

    res.json(courses)


exports.add = (req, res)->
  delete  req.body.menu
  delete req.body._id
  course = new MenuCourse(req.body)
  course.menu = req.menu._id

  course.save (err)->
    if err
      return res.status(400).send({message: err})

    res.json(course)

exports.update = (req, res)->
  cond = 
    menu: req.menu._id
    _id: req.body._id
  MenuCourse.findOne cond, (e, course)->
    delete  req.body.menu
    delete req.body._id
    course = extend(course, req.body)

    course.save (e)->
      if e
        return res.status(400).send({message: e.errors})

      res.json(course.toJSON())    
