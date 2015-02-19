define([
  'underscore'
  'Backbone'
], (_, Backbone)->
  RoomModel = Backbone.Model.extend(
    idAttribute: "_id"
    defaults:
      name: ''


    initialize: (options)->
      console.log 'new RoomModel'

  )

  return RoomModel

)
