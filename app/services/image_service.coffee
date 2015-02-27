extend = require('util')._extend

mongoose = require 'mongoose'
Image = mongoose.model 'Image'


exports.all = ()->

  console.log 'aaa'
  res.json({success: 'ok'})

exports.upload = (req, res)->
  delete req.body.venue

  image = new Image(req.body)
  image.venue = req.user.venue

  image.save (err)->
    if err
      return res.status(400).send({message: err})

    res.json(image)



