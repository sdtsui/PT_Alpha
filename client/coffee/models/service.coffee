define([
  'underscore'
  'Backbone'
], (_, Backbone)->
  ServiceModel = Backbone.Model.extend(
    idAttribute: "_id"
    defaults:
      name: ''
      description: ''
      unitMethod: 'HEAD'
      unitRate: ''
      isActive: true
      
    initialize: (options)->
      @options = options 
  )

  return ServiceModel

)