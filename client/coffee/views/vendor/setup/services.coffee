define([
  'jquery'
  'underscore'
  'Backbone'
  'models/venue'
  'views/shared/alert_message'
  'text!templates/vendor/setup/services.html'
], ($
    _
    Backbone
    VenueModel
    AlertMessage
    ServicesTemplate
  )->

    ServicesSetupView = Backbone.View.extend(

      tagName: 'div'
      # className: 'sticky'
      events:
        'click .cancelVenue': 'cancelVenue'
        'click .updateVenue': 'updateVenue'
        # 'click .deleteVenue': 'deleteVenue'
    
      initialize: (options)->
        @options = options

      render: ()->
        that = this
        tpl = _.template(ServicesTemplate, {})
        @$el.html tpl
        @
    )
    return ServicesSetupView
)