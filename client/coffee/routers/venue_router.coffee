define([
  'jquery'
  'underscore'
  'Backbone'
  'views/authorized_layout'
  'views/dashboard'
  'views/auths/signup'
  'views/auths/signin'
  'views/vendor/setup'
  'views/vendor/rooms'
  'views/vendor/menus'
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
      VendorRoomsView
      VendorMenusView
      VendorMenuItemsView
    )->
      AppRouter = Backbone.Router.extend(
        routes:
          'signup': 'signup'
          'signin': 'signin'
          # default action
          'setup': 'vendorSetup'
          'rooms': 'vendorRooms'
          'menus': 'vendorMenus'
          'menu-items': 'vendorMenuItems'
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
          @authorizeDom('setup')
          view = new VendorSetupView()
          view.render()

        vendorRooms: ->
          @authorizeDom('rooms')
          view = new VendorRoomsView()
          view.render()

        vendorMenuItems: ->
          @authorizeDom('menu-items')
          view = new VendorMenuItemsView()
          view.render()

        vendorMenus: ->
          @authorizeDom('menus')
          view = new VendorMenusView()
          view.render()


        authorizeDom: (activeClass)->
          activeClass ||= null
          if ! PrivateTable.getCurrentUser()
            window.location = "/#/signin"
            return
          
          $('#backbone-app').html(AuthorizedLayoutView.render({activeClass: activeClass}).el)
      )

      return{
        initialize: (options)->
          appRoute = new AppRouter()
          Backbone.history.start()
      }

)
