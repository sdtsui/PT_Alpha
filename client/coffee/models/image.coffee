define([
  'underscore'
  'Backbone'
], (_, Backbone)->
  ImageModel = Backbone.Model.extend(
    idAttribute: "_id"
    defaults:
      fileName: ''
      fileType: ''
      fileSize: 0
      filePath: ''
      fileUrl: ''
      url: ''
      tags: []

    
    initialize: (options)->
      console.log 'new ImageModel'

  )

  return ImageModel

)
