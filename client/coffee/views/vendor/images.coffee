define([
  'jq'
  'underscore'
  'Backbone'
  'dropzone'
  'models/image'
  'collections/images'
  'views/shared/alert_message'
  'views/vendor/images/list'
  'text!templates/vendor/images.html'
], ($
    _
    Backbone
    dropzone
    ImageModel
    ImagesCollection
    AlertMessage
    ListImagesView
    VendorImagesTemplate
  )->
    Dropzone = window.Dropzone
    VendorImagesView = Backbone.View.extend(
      el: '#setupContent'

      events:
        'click .uploadImages': 'uploadImages'
        'click .toggleDropzone': 'toggleDropzone'
        'click .menu-list li.item a': 'selectRoom'

      toggleDropzone: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @$('#s3Dropzone').toggle()
        if @$('#s3Dropzone').is(':visible')
          $e.text('hide dropzone')
        else
          $e.text('show dropzone')

      uploadImages: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @fileUpload.processQueue()

      initialize: (options)->
        @getS3Policy()
        @s3Config = null 
        @fileUpload = null
        @images = new ImagesCollection()
        @images.url = '/api/images'
        @images.fetch()

      listImages: ()->
        view = new ListImagesView({images: @images})
        @$('.listImages').html view.render().el

      getS3Policy: ()->
        that = this
        $.ajax
          url: '/api/s3/policy'
          method: 'GET'
          datatype: 'json'
          data: {}
          success: (response)->
            console.log 'response'
            that.s3Config = response
            if that.fileUpload
              that.fileUpload.options.url = "https://#{response.bucket}.s3.amazonaws.com"
            that.populateS3Form(response)
          error: (response)->
            console.log response

      populateS3Form: (conf)->
        @$('input[name="key"]').val("uploads/#{PrivateTable.getCurrentUser().venue}/${filename}")
        @$('input[name="acl"]').val()
        @$('input[name="policy"]').val(conf.policy)
        @$('input[name="signature"]').val(conf.signature)
        @$('input[name="AWSAccessKeyId"]').val(conf.accessId)

      buildFileUpload: ()->
        that = this
        options = 
          paramname: 'pic'
          maxfiles: 5
          parallelUploads: 1
          maxFilesize: 30
          maxThumbnailFilesize: 8
          thumbnailWidth: 250
          thumbnailHeight: 150
          url: '/'
          autoProcessQueue: false
          acceptedMimeTypes: "image/bmp,image/gif,image/jpg,image/jpeg,image/png"
          complete: (file, done)->
            console.log 'complete'
            console.log file
            xml = $.parseXML(done)
          success: (file, response)->
            $xml = $($.parseXML(response))
            that.uploadToServer(file, $xml)
            
        @fileUpload = new Dropzone( '#s3Dropzone', options)

      uploadToServer: (file, xml)->
        that = this
        params = 
          fileName: file.name
          fileType: file.type
          fileSize: file.size
          filePath: xml.find('Key').text()
          fileUrl: xml.find('Location').text()
        image = new ImageModel(params)
        image.url = "/api/images/upload"
        image.save image.toJSON(),
          success: (model, response, options)->
            console.log model
            that.images.unshift(image)
            that.listImages()
          error: (model, response, options)->
            msg = new AlertMessage({messages: ["There are some errors"]})
            that.$el.prepend(msg.render().el)        


      render: ()->
        that = this
        tpl = _.template(VendorImagesTemplate, {})
        @$el.html(tpl)
        @buildFileUpload()
        @listImages()
        @

    )
    return VendorImagesView

)  