define([
  'jq'
  'underscore'
  'Backbone'
  'views/shared/alert_message'
  'text!templates/vendor/rooms/services.html'
], ($
    _
    Backbone
    AlertMessage
    RoomServicesTemplate
  )->
    RoomServicesView = Backbone.View.extend(
      tagName: 'div'
      className: 'row'


      initialize: (options)->
        @room = options.room
        

      render: ()->
        that = this
        tpl = _.template(RoomServicesTemplate, {_: _})
        @$el.html(tpl)
        @

    )
    return RoomServicesView

)