express  = require 'express'
router = express.Router()
api = require('../../../libs/authentication')
MenuCourseService = require('../../services/menu_course_service')

module.exports = (app, passport) ->
  app.use '/api/menu_courses', api.requiresLogin, router


  router.get "/", (req, res)->
    MenuCourseService.all(req, res)

  router.post '/add', (req, res)->
    MenuCourseService.add(req, res)

  router.put '/update', (req, res)->
    MenuCourseService.update(req, res)
