define([
  'jquery'
  'underscore'
  'Backbone'
  'views/auths/signup'
], ($, _, Backbone, SignupView)->
  AppRouter = Backbone.Router.extend(
    routes:
      ''  : 'index'

    index: ->
      view = new SignupView({})
      view.render()
      $('#backbone-app').html(view.render())
  )

  return{
    initialize: (options)->
      appRoute = new AppRouter()
      Backbone.history.start()
  }

)
