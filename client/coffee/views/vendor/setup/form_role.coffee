define([
  'jquery'
  'underscore'
  'Backbone'
  'views/shared/alert_message'
  'text!templates/vendor/setup/form_role.html'
], ($
    _
    Backbone
    AlertMessage
    FormRoleTemplate
  )->

    FormServiceSetupView = Backbone.View.extend(

      tagName: 'div'
      className: 'role'
      events:
        'click .cancelRole': 'cancelRole'
        'click .saveRole': 'saveRole'
        'click .deleteRole': 'deleteRole'

      cancelRole: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @$el.remove()

      saveRole: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        console.log 'saveRole'

      deleteRole: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        console.log 'deleteRole'
        @$el.remove()

      initialize: (options)->
        @options = options
        @roles = options.roles
        @formRole = options.formRole        
        @initConstant()

      initConstant: ()->
        @ROLES =
          EVENT_MANAGER: 'event manager'
          OWNER: 'owner'
          EVENT_COORDINATOR: 'event coordinator'
          GENERAL_MANAGER: 'general manager'
          PARTNER: 'partner'

      bindingDom: ()->
        @$name = @$('input[name="name"]')
        @$name.on 'blur', => 
          @formRole.set name: @$name.val()

        @$email = @$('input[name="email"]')
        @$email.on 'change', => 
          @formRole.set email: @$email.val()

        @$role = @$('input[name="role"]')
        @$role.on 'click', => 
          @formRole.set role: @$role.is(':checked')        

        @$phone = @$('input[name="phone"]')
        @$phone.on 'blur', => 
          @formRole.set phone: @$phone.val()

        @$isActive = @$('input[name="isActive"]')
        @$isActive.on 'click', => 
          @formRole.set isActive: @$isActive.is(':checked')        

      render: ()->
        tpl = _.template(FormRoleTemplate, {_: _, ROLES: @ROLES, role: @formRole.toJSON()})
        @$el.html(tpl)
        @                
    )
    return FormServiceSetupView
)