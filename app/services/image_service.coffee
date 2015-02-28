extend = require('util')._extend

mongoose = require 'mongoose'
Image = mongoose.model 'Image'


exports.all = (req, res)->
  cond = 
    venue: req.user.venue
  if req.query && req.query.term
    cond.tags = {'$all': req.query.term}
    
  Image.find(cond).limit(20).exec (e, images)->
    if e
      return res.json([])

    res.json(images)

exports.upload = (req, res)->
  delete req.body.venue

  image = new Image(req.body)
  image.venue = req.user.venue

  image.save (err)->
    if err
      return res.status(400).send({message: err})

    res.json(image)


exports.remove = (req, res)->

  cond = 
    venue: req.user.venue
    _id: req.body._id

  Image.remove cond, (e, image)->
    if e
      return res.status(400).send({message: 'not found image'})
    res.json({message: 'ok'})


exports.update = (req, res)->
  cond = 
    venue: req.user.venue
    _id: req.body._id
  Image.findOne cond, (e, image)->
    delete  req.body.venue
    delete req.body._id
    image = extend(image, req.body)

    image.save (e)->
      if e
        return res.status(400).send({message: e.errors})

      res.json(image.toJSON())    
