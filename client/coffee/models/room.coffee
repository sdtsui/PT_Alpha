define([
  'underscore'
  'Backbone'
], (_, Backbone)->
  RoomModel = Backbone.Model.extend(
    idAttribute: "_id"
    defaults:
      name: ''
      roomType: 'private'
      roomSize:
        value: 0
        unit: ''        
      description: ''
      isActive: true
      requireApproval: true
      revenueOn: true
      rate:
        day: 0
        night: 0
      fee:
        rental: 0
        cleaning: 0
      overage:
        value: 0
        unit: ''
      houseRule: ''
      cancelPolicy: ''
      leadTime: ''

    initialize: (options)->
      console.log 'new RoomModel'

  )

  return RoomModel

)
