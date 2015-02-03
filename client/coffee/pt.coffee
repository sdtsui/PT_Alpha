define([
  'jquery'
  'underscore'
  'Backbone'
  'routers/venue_router'
], ($, _, Backbone, Router)->
  initialize = ()->
    Router.initialize()


  return {
    init: initialize
  }
)
