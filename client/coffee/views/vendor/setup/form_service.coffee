define([
  'jquery'
  'underscore'
  'Backbone'
  'models/service'
  'views/shared/alert_message'
  'text!templates/vendor/setup/form_service.html'
], ($
    _
    Backbone
    ServiceModel
    AlertMessage
    FormServicesTemplate
  )->

    FormServiceSetupView = Backbone.View.extend(

      tagName: 'div'
      events:
        'click .cancelService': 'cancelService'
        'click .saveService': 'saveService'
        'click .deleteService': 'deleteService'

      cancelService: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @$el.remove()

      saveService: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        console.log 'saveService'

      deleteService: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @$('.form-wrap').html('')
        console.log 'deleteService'

      initialize: (options)->
        @services = options.services
        @formService = options.formService
        @initConstant()

      initConstant: ->
        @UNIT_METHODS =
          HEAD: '$ per guest'
          ITEM: '$ per item'
          EVENT: '$ per event'
          TIME: '$ per hour'
          OVER_TIME: '$ per hour over'
          DOZEN: '$ per 12 items'

      bindingDom: ()->
        @$name = @$('input[name="name"]')
        @$name.on 'blur', => 
          @formService.set name: @$name.val()

        @$description = @$('input[name="description"]')
        @$description.on 'blur', => 
          @formService.set description: @$description.val()

        @$unitRate = @$('input[name="unitRate"]')
        @$unitRate.on 'blur', => 
          @formService.set unitRate: @$unitRate.val()

        @$isActive = @$('input[name="isActive"]')
        @$isActive.on 'click', => 
          @formService.set isActive: @$isActive.is(':checked')


      render: ()->
        tpl = _.template(FormServicesTemplate, {_: _, service: @formService.toJSON(), UNIT_METHODS: @UNIT_METHODS})
        @$el.html(tpl)
        @bindingDom()
        @        

    )

    return FormServiceSetupView
)