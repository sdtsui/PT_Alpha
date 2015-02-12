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


      render: ()->
        tpl = _.template(FormRoleTemplate, {_: _, ROLES: @ROLES, role: @formRole.toJSON()})
        @$el.html(tpl)
        @                
    )
    return FormServiceSetupView
)