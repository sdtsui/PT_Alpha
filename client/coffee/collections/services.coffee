define([
  'jquery',
  'underscore'
  'Backbone'
  'models/service'
], ($, _, Backbone, ServiceModel)->
  ServicesCollection = Backbone.Collection.extend(
    model: ServiceModel,
    initialize: (options)->
      console.log options
    url: '/api/services/'
  )
  return ServicesCollection
)
