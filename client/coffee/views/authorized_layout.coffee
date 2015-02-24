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

    render: (opts)->
      activeClass = opts.activeClass || 'setup'
      tpl = _.template(AuthorizedLayoutTemplate, {})
      @$el.html(tpl)
      @$('.inline-list > li').removeClass('active')
      @$(".inline-list .nav-#{activeClass}").addClass('active')
      @$('#topnav').html TopnavView.render().el
      @
  )
  return new AuthorizedLayoutView()
)