define([
  'jquery'
  'underscore'
  'Backbone'
  'models/signup'
  'views/shared/alert_message'
  'text!templates/auths/signup.html'
], ($, _, Backbone, SignupModel, AlertMessage, SignupTemplate)->

  SignupView = Backbone.View.extend(
    tagName: 'div'
    className: 'row collapse'

    initialize: (options)->
      @model = new SignupModel()


    events:
      'submit form': 'onFormSubmit'
      'change input[type!="submit"]': 'onInputChange'

    onFormSubmit: (e)->
      that = this
      e.preventDefault()
      e.stopPropagation()    
      $e = $(e.currentTarget)
      console.log @model
      if @model.isValid()
        jsonData = @model.toJSON()
        $.ajax
          url: '/api/auth/signup'
          type: 'POST'
          data: jsonData
          dataType: 'json'
          success: (resp)->
            console.log resp
            if resp.errors
              msg = new AlertMessage({messages: that.buildServerErrorMessages(resp.errors)})
              $e.prepend(msg.render().el)
            else
              PrivateTable.setCurrentUser(resp)
              window.location = "/#/"
      else
        msg = new AlertMessage({messages: that.buildClientErrorMessages()})
        $e.prepend(msg.render().el)

    onInputChange: (e)->
      true    
    bindingDom: ->
      @$venueName = @$('input[name="venueName"]')
      @$venueName.on 'blur', => 
        @model.set venueName: @$venueName.val()

      @$venueUrl = @$('input[name="venueUrl"]')
      @$venueUrl.on 'blur', => 
        @model.set venueUrl: @$venueUrl.val()

      @$name = @$('input[name="name"]')
      @$name.on 'blur', => 
        @model.set name: @$name.val()

      @$jobTitle = @$('input[name="jobTitle"]')
      @$jobTitle.on 'blur', => 
        @model.set jobTitle: @$jobTitle.val()

      @$email = @$('input[name="email"]')
      @$email.on 'blur', => 
        @model.set email: @$email.val()

      @$password = @$('input[name="password"]')
      @$password.on 'blur', => 
        @model.set password: @$password.val()


    buildServerErrorMessages: (errors)->
      messages = []
      _.each errors, (errs, field)->
        console.log field
        console.log errs
        if errs instanceof String
          messages.push("#{field} #{errs}")
        else
          if errs instanceof Array
            _.each errs, (error)->
              messages.push("#{field} #{error}")
          else
            messages.push("#{errs?.message}")

      return messages

    buildClientErrorMessages: ()->
      messages = []
      _.each @model.validationError, (errors, field)->
        console.log field
        console.log errors
        _.each errors, (error)->
          messages.push("#{field} #{error}")
      return messages

    render: ->
      tpl = _.template(SignupTemplate, {})
      @$el.html(tpl)
      @bindingDom()
      @
  )

  return SignupView

)
