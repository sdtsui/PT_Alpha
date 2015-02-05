define([
  'jquery'
  'underscore'
  'Backbone'
  'models/signup'
  'views/shared/alert_message'
  'text!templates/auths/signin.html'
], ($, _, Backbone, SignupModel, AlertMessageView, SigninTemplate)->

  SigninView = Backbone.View.extend(
    tagName: 'div'
    className: 'row collapse'

    initialize: (options)->
      @model = new SignupModel()


    events:
      'submit form': 'signIn'

    signIn: (e)->
      e.preventDefault()
      e.stopPropagation()    
      $e = $(e.currentTarget)
      jsonData = @model.toJSON()
      console.log jsonData
      $.ajax
        url: '/api/auth/login'
        type: 'POST'
        data: jsonData
        dataType: 'json'
        success: (resp)->
          console.log resp
          if resp.errors
            msg = new AlertMessageView({type: 'warning', messages: [resp.errors]})
            console.log msg.render().el
            $e.prepend(msg.render().el)
          else
            PrivateTable.setCurrentUser(resp)
            window.location = "/#/"

    bindingDom: ->
      @$email = @$('input[name="email"]')
      @$email.on 'blur', => 
        @model.set email: @$email.val()

      @$password = @$('input[name="password"]')
      @$password.on 'blur', => 
        @model.set password: @$password.val()


    render: ->
      tpl = _.template(SigninTemplate, {})
      @$el.html(tpl)
      @bindingDom()
      @
  )

  return SigninView

)    