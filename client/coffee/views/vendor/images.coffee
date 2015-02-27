define([
  'jq'
  'underscore'
  'Backbone'
  'dropzone'
  'models/room'
  'collections/rooms'
  'views/shared/alert_message'
  'text!templates/vendor/images.html'
], ($
    _
    Backbone
    dropzone
    RoomModel
    RoomsCollection
    AlertMessage
    VendorImagesTemplate
  )->
    Dropzone = window.Dropzone
    VendorImagesView = Backbone.View.extend(
      el: '#setupContent'

      events:
        'click .addNewRoom': 'addNewRoom'
        'click .menu-list li.item a': 'selectRoom'

      initialize: (options)->
        @getS3Policy()

      getS3Policy: ()->
        that = this
        $.ajax
          url: '/api/s3/policy'
          method: 'GET'
          datatype: 'json'
          data: {}
          success: (response)->
            console.log 'response'
            console.log response
          error: (response)->
            console.log response    

      buildFileUpload: ()->
        @fileupload = new Dropzone( '.dropzone',
            url: '/api/images/upload'
            method: 'POST'
            parallelUploads: 1
            autoProcessQueue: false
          )

      render: ()->
        that = this
        tpl = _.template(VendorImagesTemplate, {})
        @$el.html(tpl)
        @buildFileUpload()
        @

    )
    return VendorImagesView

)  