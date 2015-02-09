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
      events:
        'click .cancelRole': 'cancelRole'
        'click .saveRole': 'saveRole'
        'click .deleteRole': 'deleteRole'

      cancelRole: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @$el.remove()

      initialize: (options)->
        @options = options

      render: ()->
        tpl = _.template(FormRoleTemplate, {})
        @$el.html(tpl)
        @                
    )
    return FormServiceSetupView
)