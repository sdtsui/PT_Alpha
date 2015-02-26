define([
  'jq'
  'underscore'
  'Backbone'
  'dropzone'
  'models/room'
  'collections/rooms'
  'views/shared/alert_message'
  # 'views/shared/fileupload'
  'text!templates/vendor/images.html'
], ($
    _
    Backbone
    dropzone
    RoomModel
    RoomsCollection
    AlertMessage
    # FileUploadView
    VendorImagesTemplate
  )->
    Dropzone = window.Dropzone
    VendorImagesView = Backbone.View.extend(
      el: '#setupContent'

      events:
        'click .addNewRoom': 'addNewRoom'
        'click .menu-list li.item a': 'selectRoom'

      initialize: (options)->

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