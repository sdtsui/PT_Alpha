define([
  'jquery'
  'underscore'
  'Backbone'
  'collections/roles'
  'models/role'
  'views/shared/alert_message'
  'views/vendor/setup/form_role'
  'text!templates/vendor/setup/roles.html'
], ($
    _
    Backbone
    RolesCollection
    RoleModel
    AlertMessage
    FormRoleView
    RolesTemplate
  )->

    RolesView = Backbone.View.extend(

      tagName: 'div'
      className: 'row'
      events:
        'click .addNewRole': 'addNewRole'

      addNewRole: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @buildForm()

      initialize: (options)->
        @options = options 
        @roles = new RolesCollection()
        @roles.url = '/api/roles'
        @roles.fetch()
        @formRole = new RoleModel()

      buildForm: ()->
        view = new FormRoleView({roles: @roles, formRole: @formRole})
        @$('.form-wrap').html view.render().el


      render: ()->
        that = this
        tpl = _.template(RolesTemplate, {})
        @$el.html tpl
        @
    )
    return RolesView

)