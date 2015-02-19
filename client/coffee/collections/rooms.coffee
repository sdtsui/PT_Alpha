define([
  'jquery',
  'underscore'
  'Backbone'
  'models/room'
], ($, _, Backbone, RoomModel)->
  RoomsCollection = Backbone.Collection.extend(
    model: RoomModel,
    initialize: (options)->
      console.log options
    url: '/api/rooms/'
  )
  return RoomsCollection
)
