define([
  'jquery'
  'underscore'
  'Backbone'
  'text!templates/auths/signup.html'
], ($, _, Backbone, SignupTemplate)->

  SignupView = Backbone.View.extend(
    className: 'row collapse'
    initialize: (options)->


    events:
      'submit form': 'onFormSubmit'
      'change input[type!="submit"]': 'onInputChange'

    onInputChange: (e)->
      console.log e
      
    render: ->
      tpl = _.template(SignupTemplate, {})
      @$el.html(tpl)
  )

  return SignupView

)
