define([
  'jq'
  'underscore'
  'Backbone'
  'views/shared/alert_message'
  'text!templates/vendor/rooms/room.html'
], ($
    _
    Backbone
    AlertMessage
    RoomTemplate
  )->
    RoomView = Backbone.View.extend(
      tagName: 'div'
      className: 'row'


      initialize: (options)->
        @room = options.room
        

      render: ()->
        that = this
        tpl = _.template(RoomTemplate, {_: _})
        @$el.html(tpl)
        @

    )
    return RoomView

)      