define([
  'jq'
  'underscore'
  'Backbone'
  'dropzone'
  'models/image'
  'collections/images'
  'views/shared/alert_message'
  'text!templates/vendor/images/image.html'
], ($
    _
    Backbone
    dropzone
    ImageModel
    ImagesCollection
    AlertMessage
    ImageTemplate
  )->
    ListImagesView = Backbone.View.extend(
      tagName: 'tr'
      events:
        'click .uploadImages': 'uploadImages'
        'click .toggleDropzone': 'toggleDropzone'
        'click .menu-list li.item a': 'selectRoom'

      initialize: (options)->
        @options = options
        @image = options.image
        console.log @image
        
      render: ()->
        that = this
        tpl = _.template(ImageTemplate, {_: _, image: @image.toJSON()})
        @$el.html(tpl)
        @

    )
    return ListImagesView

)          