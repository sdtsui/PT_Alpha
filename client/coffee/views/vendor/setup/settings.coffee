define([
  'jquery'
  'underscore'
  'Backbone'
  'models/venue'
  'views/shared/alert_message'
  'text!templates/vendor/setup/settings.html'
], ($, _, Backbone, VenueModel, AlertMessage, SettingsTemplate)->

  SettingsView = Backbone.View.extend(
    tagName: 'div'
    events:
      'click .cancelSettings': 'cancelSettings'
      'click .saveSettings': 'saveSettings'
      # 'click .deleteVenue': 'deleteVenue'

    cancelSettings: (e)->
      that = this
      e.preventDefault()
      e.stopPropagation()
      that.settings = _.clone(that.model)
      @buildHtml()

    saveSettings: (e)->
      that = this
      e.preventDefault()
      e.stopPropagation()
      $.ajax
        url: '/api/settings'
        method: 'PUT'
        datatype: 'json'
        data: that.settings
        success: (response)->
          that.model = _.clone(that.settings)
          msg = new AlertMessage({type: 'success', messages: ["Settings was updated successfully."]})
          that.$el.prepend(msg.render().el)
        error: (response)->
          msg = new AlertMessage({messages: ["There are some errors"]})
          that.$el.prepend(msg.render().el)


    initialize: (options={})->
      that = this
      that.options = options || {}
      that.settings = {}
      that.model = {}

    bindingDom: ()->
      @$introEmail = @$('textarea[name="introEmail"]')
      @$introEmail.on 'blur', =>
        @settings.introEmail = @$introEmail.val()

      @$marketIntro = @$('textarea[name="marketIntro"]')
      @$marketIntro.on 'blur', =>
        @settings.marketIntro = @$marketIntro.val()

      @$emailSuccess = @$('textarea[name="emailSuccess"]')
      @$emailSuccess.on 'blur', =>
        @settings.emailSuccess = @$emailSuccess.val()

    buildHtml: ()->
      that = this
      tpl = _.template(SettingsTemplate, {settings: that.settings})
      that.$el.html(tpl)
      @bindingDom()

    render: ()->
      that = this
      $.ajax
        url: '/api/settings'
        method: 'GET'
        datatype: 'json'
        success: (response)->
          that.settings = response
          that.model = _.clone(that.settings)
          that.buildHtml()
        error: (response)->
          console.log response

      @

  )
  return SettingsView

)