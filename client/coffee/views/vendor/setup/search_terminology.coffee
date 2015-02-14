define([
  'jquery'
  'underscore'
  'Backbone'
  'views/shared/alert_message'
  'text!templates/vendor/setup/search_terminology.html'
], ($
    _
    Backbone
    AlertMessage
    SearchTeminologyTemplate
  )->

    SearchTerminologyView = Backbone.View.extend(

      tagName: 'div'
      className: 'columns large-4 left-col searchTerminology'
      events:
        'click .cancelRole': 'cancelRole'
        'click .saveRole': 'saveRole'
        'click .deleteRole': 'deleteRole'

      cancelRole: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @$el.remove()
      
      initialize: (options)->
        @options = options
        @type = options.type

      render: ()->
        tpl = _.template(SearchTeminologyTemplate, {_: _})
        @$el.html(tpl)
        @
    )
    return SearchTerminologyView
)