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
        that = this
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        isNew = @formService.isNew()
        if @formService.isValid()
          if isNew
            @formService.url = "/api/services/create"
          else
            @formService.url = "/api/services/update"

          @formService.save @formService.toJSON(),
            success: (model, response, options)->
              if isNew
                that.services.add that.formService
              
              msg = new AlertMessage({type: 'success', messages: ["Service was saved successfully."]})
              that.$el.prepend(msg.render().el)

            error: (model, response, options)->
              console.log 'errror'
              console.log response
              msg = new AlertMessage({messages: ["There are some errors"]})
              that.$el.prepend(msg.render().el)

      deleteService: (e)->
        that = this
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @$el.remove()
        isNew = @formService.isNew()
        if !isNew
          @formService.destroy
            success: (model, response)->
              that.services.remove that.formService

            error: (model, response)->


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

        @$description = @$('textarea[name="description"]')
        @$description.on 'blur', => 
          @formService.set description: @$description.val()

        @$unitMethod = @$('input[name="unitMethod"]')
        @$unitMethod.on 'change', => 
          @formService.set unitMethod: @$unitMethod.val()

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