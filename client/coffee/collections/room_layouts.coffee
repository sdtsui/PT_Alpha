define([
  'jquery',
  'underscore'
  'Backbone'
  'models/room_layout'
], ($, _, Backbone, RoomLayoutModel)->
  RoomLayoutsCollection = Backbone.Collection.extend(
    model: RoomLayoutModel,
    initialize: (options)->
      @room = options.room
    url: ()->
      that = this
      console.log that
      return "/api/rooms/layouts?room=#{that.room}"
  )
  return RoomLayoutsCollection
)
