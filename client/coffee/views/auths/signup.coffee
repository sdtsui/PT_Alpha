define([
  'jquery'
  'underscore'
  'Backbone'
  'text!templates/auths/signup.html'
], ($, _, Backbone, SignupTemplate)->

  SignupView = Backbone.View.extend(
    className: 'row collapse'
    initialize: (options)->

    render: ->
      tpl = _.template(SignupTemplate, {})
      @$el.html(tpl)
  )

  return SignupView

)
