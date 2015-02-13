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
        console.log @formRole.toJSON()
        isNew = @formRole.isNew()
        if isNew
          console.log 'save new role'
          @formRole.save()
        else
          @formRole.url = '/api/roles/update'
          @formRole.save()
          console.log 'update role'


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

        @$role = @$('select[name="role"]')
        @$role.on 'change', => 
          @formRole.set role: @$role.val()       

        @$phone = @$('input[name="phone"]')
        @$phone.on 'blur', => 
          @formRole.set phone: @$phone.val()

        @$isActive = @$('input[name="isActive"]')
        @$isActive.on 'click', => 
          @formRole.set isActive: @$isActive.is(':checked')

        @$notificationsNewProspectEmail = @$('input[name="notificationsNewProspectEmail"]')
        @$notificationsNewProspectEmail.on 'click', => 
          notifications = @formRole.get('notifications') || {}
          notifications.newProspect ||= {}
          notifications.newProspect.email = @$notificationsNewProspectEmail.is(':checked')
          @formRole.set notifications: notifications

        @$notificationsNewProspectPhone = @$('input[name="notificationsNewProspectPhone"]')
        @$notificationsNewProspectPhone.on 'click', => 
          notifications = @formRole.get('notifications') || {}
          notifications.newProspect ||= {}
          notifications.newProspect.phone = @$notificationsNewProspectPhone.is(':checked')
          @formRole.set notifications: notifications

        @$notificationsNewMessageEmail = @$('input[name="notificationsNewMessageEmail"]')
        @$notificationsNewMessageEmail.on 'click', => 
          notifications = @formRole.get('notifications') || {}
          notifications.newMessage ||= {}
          notifications.newMessage.phone = @$notificationsNewMessageEmail.is(':checked')
          @formRole.set notifications: notifications

        @$notificationsNewMessagePhone = @$('input[name="notificationsNewMessagePhone"]')
        @$notificationsNewMessagePhone.on 'click', => 
          notifications = @formRole.get('notifications') || {}
          notifications.newMessage ||= {}
          notifications.newMessage.phone = @$notificationsNewMessagePhone.is(':checked')
          @formRole.set notifications: notifications



        @$notificationsNewEventEmail = @$('input[name="notificationsNewEventEmail"]')
        @$notificationsNewEventEmail.on 'click', => 
          notifications = @formRole.get('notifications') || {}
          notifications.newEvent ||= {}
          notifications.newEvent.phone = @$notificationsNewEventEmail.is(':checked')
          @formRole.set notifications: notifications

        @$notificationsNewEventPhone = @$('input[name="notificationsNewEventPhone"]')
        @$notificationsNewEventPhone.on 'click', => 
          notifications = @formRole.get('notifications') || {}
          notifications.newEvent ||= {}
          notifications.newEvent.phone = @$notificationsNewEventPhone.is(':checked')
          @formRole.set notifications: notifications


        @$notificationsAbandonCartEmail = @$('input[name="notificationsAbandonCartEmail"]')
        @$notificationsAbandonCartEmail.on 'click', => 
          notifications = @formRole.get('notifications') || {}
          notifications.abandonCart ||= {}
          notifications.abandonCart.phone = @$notificationsAbandonCartEmail.is(':checked')
          @formRole.set notifications: notifications

        @$notificationsAbandonCartPhone = @$('input[name="notificationsAbandonCartPhone"]')
        @$notificationsAbandonCartPhone.on 'click', => 
          notifications = @formRole.get('notifications') || {}
          notifications.abandonCart ||= {}
          notifications.abandonCart.phone = @$notificationsAbandonCartPhone.is(':checked')
          @formRole.set notifications: notifications


      render: ()->
        tpl = _.template(FormRoleTemplate, {_: _, ROLES: @ROLES, role: @formRole.toJSON()})
        @$el.html(tpl)
        @bindingDom()
        @                
    )
    return FormServiceSetupView
)