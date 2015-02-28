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
      className: 'columns large-12'
      events:
        'click .uploadImages': 'uploadImages'
        'click .toggleDropzone': 'toggleDropzone'
        'click .menu-list li.item a': 'selectRoom'

      initialize: (options)->
        @options = options
        
      buildListImages: ()->
        view = new ImageView({})
        @$('tbody').append(view.render().el)
      
      render: ()->
        that = this
        tpl = _.template(ListImagesTemplate, {})
        @$el.html(tpl)
        @

    )
    return ListImagesView

)          