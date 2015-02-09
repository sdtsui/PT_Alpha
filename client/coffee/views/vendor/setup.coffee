define([
  'jquery'
  'underscore'
  'Backbone'
  'models/venue'
  'views/shared/alert_message'
  'views/vendor/setup/venue'
  'views/vendor/setup/terminology'
  'views/vendor/setup/services'
  'views/vendor/setup/roles'
  'views/vendor/setup/settings'
  'text!templates/vendor/setup.html'
], ($
    _
    Backbone
    VenueModel
    AlertMessage
    SetupVenueView
    TerminologyView
    ServicesView
    RolesView
    SettingsView
    VendorSetupTemplate
  )->

    VendorSetupView = Backbone.View.extend(
      # tagName: 'div'
      # className: 'sticky'
      el: '#setupContent'

      events:
        'click ul.setupMenu li': 'navMenu'
        'click .updateVenue': 'updateVenue'

    
      navMenu: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        if $e.hasClass('active')
          return
        $e.closest('ul').find('li').removeClass('active')
        $e.addClass('active')
        console.log $e.data('nav')
        switch $e.data('nav')
          when 'venue'
            @buildVenue()
          when 'terminology'
            @buildTerminology()
          when 'services'
            @buildServices()
          when 'roles'
            @buildRoles()
          when 'settings'
            @buildSettings()

      initialize: (options={})->
        @options = options



      buildTerminology: ()->
        view = new TerminologyView()
        @$('.silo.vendorSetup').html view.render().el
        
      buildServices: ()->
        view = new ServicesView()
        @$('.silo.vendorSetup').html view.render().el

      buildRoles: ()->
        view = new RolesView()
        @$('.silo.vendorSetup').html view.render().el

      buildSettings: ()->
        view = new SettingsView()
        @$('.silo.vendorSetup').html view.render().el

      buildVenue: ()->
        view = new SetupVenueView()
        @$('.silo.vendorSetup').html view.render().el

      render: ()->
        that = this
        tpl = _.template(VendorSetupTemplate, {})
        @$el.html(tpl)
        @buildVenue()
        @

    )
    return VendorSetupView

)