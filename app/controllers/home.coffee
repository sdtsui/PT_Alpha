express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
User  = mongoose.model 'User'

module.exports = (app) ->
  app.use '/', router

router.get '/', (req, res, next) ->
  console.log req.user
  res.render('home',
    title: 'HandleRoR MVC'
  )

