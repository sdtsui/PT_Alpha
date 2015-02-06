define([
  'jquery'
  'underscore'
  'Backbone'
  'models/venue'
  'text!templates/vendor/setup.html'
], ($, _, Backbone, VenueModel, VendorSetupTemplate)->

  VendorSetupView = Backbone.View.extend(
    tagName: 'div'
    className: 'sticky'
    events:
      'click a.close': 'closeAlert'

    closeAlert: (e)->
      e.preventDefault()
      e.stopPropagation()    

    initialize: (options={})->
      that = this
      that.options = options || {}
      that.venue = null

    render: ()->
      that = this
      $.get '/api/venues/mine', (v)->
        that.venue = new VenueModel(v)
        tpl = _.template(VendorSetupTemplate, {_: _, venue: that.venue.toJSON()})
        that.$el.html(tpl)
      @

  )
  return VendorSetupView

)