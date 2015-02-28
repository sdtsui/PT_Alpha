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
        'click .removeImage': 'removeImage'
        'click .addTag': 'addTag'
        'click .menu-list li.item a': 'selectRoom'

      removeImage: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @$el.remove()
        console.log 'removeImage'
      
      addTag: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        console.log 'addTag'

      initialize: (options)->
        @options = options
        @image = options.image
        
      render: ()->
        that = this
        tpl = _.template(ImageTemplate, {_: _, image: @image.toJSON()})
        @$el.html(tpl)
        @

    )
    return ListImagesView

)          