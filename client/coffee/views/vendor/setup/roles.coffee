define([
  'jquery'
  'underscore'
  'Backbone'
  'views/shared/alert_message'
  'views/vendor/setup/form_role'
  'text!templates/vendor/setup/roles.html'
], ($
    _
    Backbone
    AlertMessage
    FormRoleView
    RolesTemplate
  )->

    RolesView = Backbone.View.extend(

      tagName: 'div'
      events:
        'click .addNewRole': 'addNewRole'

      addNewRole: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @buildForm()

      initialize: (options)->
        @options = options 

      buildForm: ()->
        view = new FormRoleView()
        @$('.form-wrap').html view.render().el


      render: ()->
        that = this
        tpl = _.template(RolesTemplate, {})
        @$el.html tpl
        @
    )
    return RolesView

)