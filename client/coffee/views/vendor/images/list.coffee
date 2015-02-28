define([
  'jq'
  'underscore'
  'Backbone'
  'dropzone'
  'models/image'
  'collections/images'
  'views/shared/alert_message'
  'views/vendor/images/image'
  'text!templates/vendor/images/list.html'
], ($
    _
    Backbone
    dropzone
    ImageModel
    ImagesCollection
    AlertMessage
    ImageView
    ListImagesTemplate
  )->
    ListImagesView = Backbone.View.extend(
      tagName: 'div'
      className: 'list-images'
      events:
        'click .uploadImages': 'uploadImages'
        'click .toggleDropzone': 'toggleDropzone'
        'click .menu-list li.item a': 'selectRoom'

      initialize: (options)->
        @options = options
        @images = options.images

      buildListImages: ()->
        that = this
        that.images.forEach (image)->
          view = new ImageView({image: image, images: that.images})
          that.$('tbody').append(view.render().el)
      
      render: ()->
        that = this
        tpl = _.template(ListImagesTemplate, {images: that.images.toJSON()})
        @$el.html(tpl)
        @buildListImages()
        @

    )
    return ListImagesView

)          