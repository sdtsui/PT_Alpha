define([
  'jq'
  'underscore'
  'Backbone'
  'models/room_layout'
  'collections/room_layouts'
  'views/shared/alert_message'
  'text!templates/vendor/rooms/layouts.html'
], ($
    _
    Backbone
    RoomLayoutModel
    RoomLayoutsCollection
    AlertMessage
    RoomLayoutsTemplate
  )->
    RoomLayoutsView = Backbone.View.extend(
      tagName: 'div'
      className: 'row'


      initialize: (options)->
        @room = options.room
        console.log @room
        @layouts = new RoomLayoutsCollection({room: @room.id})
        @layouts.fetch()

      render: ()->
        that = this
        tpl = _.template(RoomLayoutsTemplate, {_: _})
        @$el.html(tpl)
        @

    )
    return RoomLayoutsView

)