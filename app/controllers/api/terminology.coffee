express  = require 'express'
router = express.Router()
api = require('../../../libs/authentication')
TerminologyService = require('../../services/terminology_service')

module.exports = (app, passport) ->
  app.use '/api/terminologies', api.requiresLogin, router


  router.get "/search", (req, res)->
    TerminologyService.search(req, res)

  router.post "/add", (req, res)->
    TerminologyService.addToVenue(req, res)

  