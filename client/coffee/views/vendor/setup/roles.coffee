define([
  'jquery'
  'underscore'
  'Backbone'
  'collections/roles'
  'models/role'
  'views/shared/alert_message'
  'views/vendor/setup/form_role'
  'text!templates/vendor/setup/roles.html'
  'text!templates/vendor/setup/item_role.html'
], ($
    _
    Backbone
    RolesCollection
    RoleModel
    AlertMessage
    FormRoleView
    RolesTemplate
    ItemRoleTemplate
  )->

    RolesView = Backbone.View.extend(

      tagName: 'div'
      className: 'row'
      events:
        'click .addNewRole': 'addNewRole'
        'click .menu-list li.item a': 'selectRole'

      addNewRole: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @formRole = new RoleModel()
        @buildForm()

      selectRole: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @formRole = @roles.get($e.data('role_id'))
        @buildForm()

      initialize: (options)->
        that = this
        @options = options 
        @roles = new RolesCollection()
        @formRole = new RoleModel()
        @roles.url = '/api/roles'
        @roles.fetch()
        @roles.fetch
          success: (collections, response, options)->
            that.buildRoleItems()
        @roles.on 'add', (s)->
          that.buildRoleItems()
        @roles.on 'remove', (s)->
          that.buildRoleItems()


      buildForm: ()->
        view = new FormRoleView({roles: @roles, formRole: @formRole})
        @$('.form-wrap').html view.render().el

      buildRoleItems: ()->
        tpl = _.template(ItemRoleTemplate, {roles: @roles.toJSON()})
        @$('.menu-list').html(tpl)

      render: ()->
        that = this
        tpl = _.template(RolesTemplate, {})
        @$el.html tpl
        @
    )
    return RolesView

)