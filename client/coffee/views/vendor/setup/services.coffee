define([
  'jq'
  'underscore'
  'Backbone'
  'models/service'
  'collections/services'
  'views/shared/alert_message'
  'views/vendor/setup/form_service'
  'text!templates/vendor/setup/services.html'
  'text!templates/vendor/setup/item_service.html'
], ($
    _
    Backbone
    ServiceModel
    ServicesCollection
    AlertMessage
    FormServiceView
    ServicesTemplate
    ItemServiceTemplate
  )->

    ServicesSetupView = Backbone.View.extend(

      tagName: 'div'
      className: 'row'
      events:
        'click .addNewService': 'addNewService'
        'click .menu-list li.item a': 'selectService'

      addNewService: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @formService = new ServiceModel()
        @buildServiceForm()

      selectService: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        # if $e.hasClass('active')
        #   return
        # $e.closest('.menu-list').find('li.item').removeClass('active')
        # $e.addClass('active')
        @formService = @services.get($e.data('service_id'))
        @buildServiceForm()

      # init
      initialize: (options)->
        that = this
        @options = options
        @formService = new ServiceModel()
        @services = new ServicesCollection()
        @services.url = "/api/services"
        @services.fetch
          success: (collections, response, options)->
            that.buildServiceItems()
        @services.on 'add', (s)->
          console.log s
          that.buildServiceItems()
        @services.on 'remove', (s)->
          console.log 'remove'
          console.log s
          that.buildServiceItems()

      buildServiceItems: ()->
        tpl = _.template(ItemServiceTemplate, {services: @services.toJSON()})
        @$('.menu-list').html(tpl)

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