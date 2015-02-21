define([
  'jquery',
  'underscore'
  'Backbone'
  'models/room_layout'
], ($, _, Backbone, RoomLayoutModel)->
  RoomLayoutsCollection = Backbone.Collection.extend(
    model: RoomLayoutModel,
    initialize: (options)->
      console.log options
    url: '/api/rooms/'
  )
  return RoomLayoutsCollection
)
