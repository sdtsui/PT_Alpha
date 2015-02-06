define([
  'jquery'
  'underscore'
  'Backbone'
  'views/dashboard'
  'views/auths/signup'
  'views/auths/signin'
], ($, _, Backbone, DashboardView, SignupView, SigninView)->
  AppRouter = Backbone.Router.extend(
    routes:
      'signup': 'signup'
      'signin': 'signin'
      # default action
      '/'  : 'index'
      ''  : 'index'

    index: ->
      console.log PrivateTable.getCurrentUser()
      if PrivateTable.getCurrentUser()
        @dashboard()
      else
        window.location = "/#/signin"

    dashboard: ->
      $.get '/api/users/me', (result)->
        console.log 'api/users/me'
        console.log result
      view = new DashboardView({})
      view.render()
      $('#backbone-app').html(view.render().el)

    signup: ->
      view = new SignupView({})
      view.render()
      $('#backbone-app').html(view.render().el)

    signin: ->
      view = new SigninView({})
      view.render()
      $('#backbone-app').html(view.render().el)

  )

  return{
    initialize: (options)->
      appRoute = new AppRouter()
      Backbone.history.start()
  }

)
