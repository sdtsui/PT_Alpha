define([
  'jq'
  'underscore'
  'Backbone'
  'collections/services'
  'views/shared/alert_message'
  'text!templates/vendor/rooms/services.html'
], ($
    _
    Backbone
    ServicesCollection
    AlertMessage
    RoomServicesTemplate
  )->
    RoomServicesView = Backbone.View.extend(
      tagName: 'div'
      className: 'row'

      events:
        'click .toggleService': 'toggleService'

      toggleService: (e)->
        $e = $(e.currentTarget)
        services = @room.get('services') || []
        existed = services.indexOf($e.data('id'))
        if existed >=0
          services.splice(existed, 1)
        else
          services.push $e.data('id')

        @room.set services: services
        @updateRoom()

      updateRoom: ()->
        that = this
        @room.url = '/api/rooms/update'

        @room.save @room.toJSON(),
          success: (model, response, options)->
            console.log 'updated success'
          error: (model, response, options)->
            console.log 'error'
            console.log response
            msg = new AlertMessage({messages: ["There are some errors"]})
            that.$el.prepend(msg.render().el)        


      initialize: (options)->
        @room = options.room
        @services = new ServicesCollection()
        @services.url = '/api/services'

      buildHtml: ()->
        that = this
        tpl = _.template(RoomServicesTemplate, {_: _, room: @room.toJSON(), services: @services.toJSON()})
        @$el.html(tpl)

      render: ()->
        that = this
        that.services.fetch 
          success: (collections, response, options)->
            that.buildHtml()        
        @

    )
    return RoomServicesView

)