define([
  'jquery'
  'underscore'
  'Backbone'
  'text!templates/dashboard.html'
], ($, _, Backbone, DashboardTemplate)->

  DashboardView = Backbone.View.extend(
    tagName: 'div'
    className: 'inner-wrap'

    initialize: (options)->


    events:
      'click a': 'a'


    render: ->
      tpl = _.template(DashboardTemplate, {})
      @$el.html(tpl)
      @
  )
)