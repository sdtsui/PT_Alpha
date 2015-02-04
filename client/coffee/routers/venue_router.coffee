define([
  'jquery'
  'underscore'
  'Backbone'
  'views/dashboard'
  'views/auths/signup'
], ($, _, Backbone, DashboardView, SignupView)->
  AppRouter = Backbone.Router.extend(
    routes:
      'signup': 'signup'
      ''  : 'index'

    index: ->
      if PrivateTable.getCurrentUser()
        @dashboard()
      else
        window.location = "/#/signup"

    dashboard: ->
      view = new DashboardView({})
      view.render()
      $('#backbone-app').html(view.render().el)

    signup: ->
      view = new SignupView({})
      view.render()
      $('#backbone-app').html(view.render().el)

  )

  return{
    initialize: (options)->
      appRoute = new AppRouter()
      Backbone.history.start()
  }

)
