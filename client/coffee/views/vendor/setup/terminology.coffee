define([
  'jquery'
  'underscore'
  'Backbone'
  'models/venue'
  'views/shared/alert_message'
  'text!templates/vendor/setup/terminology.html'
], ($, _, Backbone, VenueModel, AlertMessage, TerminologyTemplate)->

  TerminologySetupView = Backbone.View.extend(
    tagName: 'div'
    # className: 'sticky'
    events:
      'click .cancelVenue': 'cancelVenue'
      'click .updateVenue': 'updateVenue'
      # 'click .deleteVenue': 'deleteVenue'

    cancelVenue: (e)->
      e.preventDefault()
      e.stopPropagation()
      @venue = @model.clone()

    updateVenue: (e)->
      e.preventDefault()
      e.stopPropagation()


    initialize: (options={})->
      that = this
      that.options = options || {}
      that.setting = {}

 
    buildHtml: ()->
      tpl = _.template(TerminologyTemplate, {_: _, setting: @setting})
      @$el.html tpl

    render: ()->
      that = this
      $.ajax
        url: '/api/settings'
        method: 'GET'
        datatype: 'json'
        success: (response)->
          that.setting = response
          that.buildHtml()
        error: (response)->
          msg = new AlertMessage({messages: ["There are some errors"]})
          that.$el.prepend(msg.render().el)    
      @

  )
  return TerminologySetupView

)