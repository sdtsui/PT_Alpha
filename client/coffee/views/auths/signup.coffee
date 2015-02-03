define([
  'jquery'
  'underscore'
  'Backbone'
  'models/signup'
  'text!templates/auths/signup.html'
], ($, _, Backbone, SignupModel, SignupTemplate)->

  SignupView = Backbone.View.extend(
    tagName: 'div'
    className: 'row collapse'

    initialize: (options)->
      @model = new SignupModel()


    events:
      'submit form': 'onFormSubmit'
      'change input[type!="submit"]': 'onInputChange'

    onFormSubmit: ()->
      console.log @model
      return false
    onInputChange: (e)->
      console.log e
    
    bindingDom: ->
      @$venueName = @$('input[name="venueName"]')
      @$venueName.on 'keyup', => 
        @model.set venueName: @$venueName.val()

      @$venueUrl = @$('input[name="venueUrl"]')
      @$venueUrl.on 'keyup', => 
        @model.set venueUrl: @$venueUrl.val()

      @$fullName = @$('input[name="fullName"]')
      @$fullName.on 'keyup', => 
        @model.set fullName: @$fullName.val()

      @$jobTitle = @$('input[name="jobTitle"]')
      @$jobTitle.on 'keyup', => 
        @model.set jobTitle: @$jobTitle.val()

      @$email = @$('input[name="email"]')
      @$email.on 'keyup', => 
        @model.set email: @$email.val()

      @$password = @$('input[name="password"]')
      @$password.on 'keyup', => 
        @model.set password: @$password.val()

    populateFields: ->
      @$('input[name="venueName"]').val @model.get('venueName')

    render: ->
      tpl = _.template(SignupTemplate, {})
      @$el.html(tpl)
      @bindingDom()
      @populateFields()
      @
  )

  return SignupView

)
