define([
  'jQuery'
  'Underscore'
  'Backbone'
  'views/auths/signup'
], ($, _, Backbone, SignupView)->
  AppRouter = Backbone.Router.extend(
    routes:
      ''  : 'index'

    index: ->
      view = new SignupView({})
      view.render()
      alert('I am backbonejs')

  )
  return{
    initialize: (options)->
      appRoute = new AppRouter()
      Backbone.history.start()
  }

)
