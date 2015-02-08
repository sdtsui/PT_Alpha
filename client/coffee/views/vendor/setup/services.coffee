define([
  'jquery'
  'underscore'
  'Backbone'
  'models/service'
  'collections/services'
  'views/shared/alert_message'
  'views/vendor/setup/form_service'
  'text!templates/vendor/setup/services.html'
], ($
    _
    Backbone
    ServiceModel
    ServicesCollection
    AlertMessage
    FormServiceView
    ServicesTemplate
  )->

    ServicesSetupView = Backbone.View.extend(

      tagName: 'div'
      events:
        'click .addNewService': 'addNewService'
      
      addNewService: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @buildServiceForm()


      # init
      initialize: (options)->
        @options = options
        @services = new ServicesCollection()
        @formService = new ServiceModel()

      buildServiceForm: ()->
        view = new FormServiceView(services: @services, formService: @formService)
        @$('.form-wrap').html(view.render().el)

      render: ()->
        that = this
        tpl = _.template(ServicesTemplate, {})
        @$el.html tpl
        @
    )
    return ServicesSetupView
)