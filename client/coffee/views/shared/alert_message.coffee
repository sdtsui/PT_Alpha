define([
  'jquery'
  'underscore'
  'Backbone'
  'text!templates/shared/alert_message.html'
], ($, _, Backbone, AlertTemplate)->

  AlertMessage = Backbone.View.extend(
    tagName: 'div'
    className: 'row alert-message-box'
    events:
      'click a.close': 'closeAlert'

    closeAlert: (e)->
      e.preventDefault()
      e.stopPropagation()    
      @$el.remove()

    initialize: (options={})->
      @options = options || {}
      if !@options.type
        @options.type = 'warning'
      
    render: ()->
      tpl = _.template(AlertTemplate, {type: @options.type, messages: @options.messages, _: _})
      $('.alert-message-box').remove()
      @$el.html(tpl)
      @      

  )
)