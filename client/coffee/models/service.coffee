define([
  'underscore'
  'Backbone'
], (_, Backbone)->
  ServiceModel = Backbone.Model.extend(
    idAttribute: "_id"
    defaults:
      name: ''
      description: ''
      unitMethod: ''
      unitRate: ''
      isActive: true
      
    initialize: (options)->
      @options = options 
  )

  return ServiceModel

)