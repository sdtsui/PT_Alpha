define([
  'jq'
  'underscore'
  'Backbone'
  'dropzone'
  'models/image'
  'collections/images'
  'views/shared/alert_message'
  'views/shared/tag'
  'text!templates/vendor/images/image.html'
], ($
    _
    Backbone
    dropzone
    ImageModel
    ImagesCollection
    AlertMessage
    TagView
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
      
      addTag: (e)->
        that = this
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        console.log 'addTag'
        console.log that.image
        args = 
          parent: that
          taggable: 'imageTags'
          placeholder: "add tag for #{that.image.get('fileName')}"
        @buildTagPanel(args)

      buildTagPanel: (options)->
        that = this
        view = new TagView(options)
        $('.listImages').append(view.render().el)
        $('.listImages .list-images').addClass('column large-8')
        $('.closeSlideout').show()


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