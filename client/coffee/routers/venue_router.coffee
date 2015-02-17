define([
  'jquery'
  'underscore'
  'Backbone'
  'views/authorized_layout'
  'views/dashboard'
  'views/auths/signup'
  'views/auths/signin'
  'views/vendor/setup'
  'views/vendor/menu_items'
], (
      $
      _
      Backbone
      AuthorizedLayoutView
      DashboardView
      SignupView
      SigninView
      VendorSetupView
      VendorMenuItemsView
    )->
      AppRouter = Backbone.Router.extend(
        routes:
          'signup': 'signup'
          'signin': 'signin'
          # default action
          'vendor/setup': 'vendorSetup'
          'menu-items': 'vendorMenuItem'
          '/'  : 'index'
          ''  : 'index'

        index: ->
          if PrivateTable.getCurrentUser()
            @vendorSetup()
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
          view.render()

        vendorMenuItem: ->
          @authorizeDom()
          view = new VendorMenuItemsView()
          view.render()


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
