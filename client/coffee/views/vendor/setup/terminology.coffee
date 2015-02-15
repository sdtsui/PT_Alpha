define([
  'jquery'
  'underscore'
  'Backbone'
  'models/venue'
  'views/shared/alert_message'
  'views/vendor/setup/search_terminology'  
  'text!templates/vendor/setup/terminology.html'
], (
    $
    _
    Backbone
    VenueModel
    AlertMessage
    SearchTerminologyView
    TerminologyTemplate
  )->

    TerminologySetupView = Backbone.View.extend(
      tagName: 'div'
      events:
        'click .addType': 'addType'
        'click .removeTerm': 'removeTerm'
        'click .closeSlideout': 'closeSlideout'

      addType: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @buildSearchHtml($e.data('kind'))

      removeTerm: (e)->
        that = this
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        console.log $e.data()
        $.ajax
          url: '/api/terminologies/remove'
          method: 'DELETE'
          datatype: 'json'
          data: $e.data()
          success: (response)->
            that.setting = response
            that.buildHtml()
          error: (response)->
            msg = new AlertMessage({messages: ["There are some errors"]})
            that.$el.prepend(msg.render().el)

      closeSlideout: (e)->
        e.preventDefault()
        e.stopPropagation()
        @$('.searchTerminology').remove()
        @$('.terminologyPanel').removeClass('column large-8')
        @$('.closeSlideout').hide()

      initialize: (options={})->
        that = this
        that.options = options || {}
        that.setting = {}

    
      buildSearchHtml: (type)->
        that = this
        @$('.searchTerminology').remove()
        view = new SearchTerminologyView({parent: that, type: type})
        @$('.terminologyPanel').addClass('column large-8')
        @$('.closeSlideout').show()
        @$el.append(view.render().el)

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