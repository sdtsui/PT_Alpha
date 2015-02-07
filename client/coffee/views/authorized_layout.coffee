define([
  'jquery'
  'underscore'
  'Backbone'
  'views/shared/topnav'
  'text!templates/authorized_layout.html'
], ($, _, Backbone, TopnavView, AuthorizedLayoutTemplate)->

  AuthorizedLayoutView = Backbone.View.extend(
    tagName: 'div'
    className: 'inner-wrap'

    initialize: (options)->


    render: ->
      tpl = _.template(AuthorizedLayoutTemplate, {})
      @$el.html(tpl)
      @$('#topnav').html TopnavView.render().el
      @
  )
  return new AuthorizedLayoutView()
)