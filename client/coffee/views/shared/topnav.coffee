define([
  'jquery'
  'underscore'
  'Backbone'
  'text!templates/shared/topnav.html'
], ($, _, Backbone, TopnavTemplate)->

  TopnavView = Backbone.View.extend(
    tagName: 'div'
    className: 'sticky'
    events:
      'click a.close': 'closeAlert'

    closeAlert: (e)->
      e.preventDefault()
      e.stopPropagation()    
      @$el.remove()

    initialize: (options={})->
      @options = options || {}
      
    render: ()->
      tpl = _.template(TopnavTemplate, {_: _})
      @$el.html(tpl)
      @      

  )
  return new TopnavView()

)