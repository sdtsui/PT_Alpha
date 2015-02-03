define([
  'jquery',
  'underscore'
  'Backbone'
  'models/venue'
], ($, _, Backbone, VenueModel)->
  VenuesCollection = Backbone.Collection.extend(
    model: VenueModel,
    initialize: (options)->
      console.log options
    url: '/api/venues/'
  )
  return VenuesCollection
)
