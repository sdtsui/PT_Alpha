define([
  'jquery'
  'underscore'
  'Backbone'
  'models/venue'
  'text!templates/vendor/setup.html'
], ($, _, Backbone, VenueModel, VendorSetupTemplate)->

  VendorSetupView = Backbone.View.extend(
    tagName: 'div'
    # className: 'sticky'
    events:
      'click a.close': 'closeAlert'

    closeAlert: (e)->
      e.preventDefault()
      e.stopPropagation()    

    initialize: (options={})->
      that = this
      that.options = options || {}
      that.venue = new VenueModel()
      that.venue.url = '/api/venues/mine'
      @initConstant()

    initConstant: ->
      @BUSINESS_HOURS = 
        OPEN: 
          5: '5:00a'
          6: '6:00a'
          7: '7:00a'
          8: '8:00a'
          9: '9:00a'
          10: '10:00a'
        CLOSE:
          19: '7:00p'
          20: '8:00p'
          21: '9:00p'
          22: '10:00p'
          23: '11:00p'

      @TIME_ZONES =
        pacific: "Pacific Standard Time"
        easter: "Eastern Standard Time"
        central: "Central Standard Time"

      @CURRENCY =
        USD: "US Dollars"
        EUR: "Euro"

      @CUISINE_TYPES =
        american: "American"
        japanese: "Japanese"
        korean: "Korean"

    render: ()->
      that = this
      that.venue.fetch 
        success: (v, response, options)->
          console.log that.venue
          tpl = _.template(VendorSetupTemplate, 
            _: _
            venue: that.venue.toJSON()
            BUSINESS_HOURS: that.BUSINESS_HOURS
            TIME_ZONES: that.TIME_ZONES
            CURRENCY: that.CURRENCY
            CUISINE_TYPES: that.CUISINE_TYPES
          )
          that.$el.html(tpl)
      @

  )
  return VendorSetupView

)