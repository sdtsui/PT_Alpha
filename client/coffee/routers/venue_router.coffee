class PrivateTable.Routers.VenueRouter extends Backbone.Router
  
  initialize: (options) ->

  routes:
    ""                      : "index"
  
  index: ->
    alert 'I am backbonejs'
    view = new PrivateTable.Views.Auths.SignupView()
    console.log view.render()