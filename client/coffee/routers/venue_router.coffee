define([
  'jquery'
  'underscore'
  'Backbone'
  'views/authorized_layout'
  'views/dashboard'
  'views/auths/signup'
  'views/auths/signin'
  'views/vendor/setup'
], ($, _, Backbone, AuthorizedLayoutView, DashboardView, SignupView, SigninView, VendorSetupView)->
  AppRouter = Backbone.Router.extend(
    routes:
      'signup': 'signup'
      'signin': 'signin'
      # default action
      'vendor/setup': 'vendorSetup'
      '/'  : 'index'
      ''  : 'index'

    index: ->
      if PrivateTable.getCurrentUser()
        @dashboard()
      else
        window.location = "/#/signin"

    dashboard: ->
      @authorizeDom()
      # view = new DashboardView({})
      # view.render()
      # $('#backbone-app').html(view.render().el)

    signup: ->
      view = new SignupView({})
      view.render()
      $('#backbone-app').html(view.render().el)

    signin: ->
      view = new SigninView({})
      $('#backbone-app').html(view.render().el)

    vendorSetup: ->
      @authorizeDom()
      view = new VendorSetupView()
      $('.silo.vendorSetup').html view.render().el

    authorizeDom: ->
      if ! PrivateTable.getCurrentUser()
        window.location = "/#/signin"
        return
      
      $('#backbone-app').html(AuthorizedLayoutView.render().el)

  )

  return{
    initialize: (options)->
      appRoute = new AppRouter()
      Backbone.history.start()
  }

)
