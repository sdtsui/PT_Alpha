define([
  'jquery'
  'underscore'
  'Backbone'
  'text!templates/authorized_layout.html'
], ($, _, Backbone, AuthorizedLayoutTemplate)->

  AuthorizedLayoutView = Backbone.View.extend(
    tagName: 'div'
    className: 'inner-wrap'

    initialize: (options)->


    render: ->
      tpl = _.template(AuthorizedLayoutTemplate, {})
      @$el.html(tpl)
      @
  )
  return new AuthorizedLayoutView()
)