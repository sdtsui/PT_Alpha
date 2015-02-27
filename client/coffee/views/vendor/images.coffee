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
            that.populateS3Form(response)
          error: (response)->
            console.log response    

      populateS3Form: (conf)->
        @$('input[name="key"]').val()
        @$('input[name="acl"]').val()
        @$('input[name="policy"]').val(conf.policy)
        @$('input[name="signature"]').val(conf.signature)
        @$('input[name="AWSAccessKeyId"]').val(conf.accessId)

      buildFileUpload: ()->
        options = 
          paramname: 'pic'
          maxfiles: 5
          parallelUploads: 1
          maxFilesize: 30
          maxThumbnailFilesize: 8
          thumbnailWidth: 250
          thumbnailHeight: 150
          url: 'http://rentme-dev.s3.amazonaws.com'
          autoProcessQueue: true
          acceptedMimeTypes: "image/bmp,image/gif,image/jpg,image/jpeg,image/png"
          # accept: (file, done)->
          #   console.log file
          #   console.log 'accept'
        @fileupload = new Dropzone( '#s3Dropzone', options)

      render: ()->
        that = this
        tpl = _.template(VendorImagesTemplate, {})
        @$el.html(tpl)
        @buildFileUpload()
        @

    )
    return VendorImagesView

)  