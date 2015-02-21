define([
  'underscore'
  'Backbone'
], (_, Backbone)->
  RoomLayoutModel = Backbone.Model.extend(
    idAttribute: "_id"
    defaults:
      name: ''
      productType: ''
      maxGuest: 0
      minHour: 0
      description: ''
      isActive: true
    
    initialize: (options)->
      console.log 'new RoomLayoutModel'

  )

  return RoomLayoutModel

)
