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