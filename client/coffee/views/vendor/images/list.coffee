define([
  'jq'
  'underscore'
  'Backbone'
  'dropzone'
  'models/image'
  'collections/images'
  'views/shared/alert_message'
  'text!templates/vendor/images.html'
], ($
    _
    Backbone
    dropzone
    ImageModel
    ImagesCollection
    AlertMessage
    ListImagesTemplate
  )->
    ListImagesView = Backbone.View.extend(
      tagName: 'div'

      events:
        'click .uploadImages': 'uploadImages'
        'click .toggleDropzone': 'toggleDropzone'
        'click .menu-list li.item a': 'selectRoom'

      initialize: (options)->
        @options = options
        
      render: ()->
        that = this
        tpl = _.template(ListImagesTemplate, {})
        @$el.html(tpl)
        @

    )
    return ListImagesView

)          