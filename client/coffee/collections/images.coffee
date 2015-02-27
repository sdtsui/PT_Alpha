define([
  'jquery',
  'underscore'
  'Backbone'
  'models/image'
], ($, _, Backbone, ImageModel)->
  ImagesCollection = Backbone.Collection.extend(
    model: ImageModel,
    initialize: (options)->
      console.log options
    url: '/api/images'
  )
  return ImagesCollection
)
