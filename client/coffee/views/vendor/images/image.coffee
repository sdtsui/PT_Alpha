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
        'click .removeTag': 'removeTag'
        'click .menu-list li.item a': 'selectRoom'

      removeImage: (e)->
        that = this
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @$el.remove()
        $.ajax
          url: '/api/images/remove'
          method: 'DELETE'
          datatype: 'json'
          data: that.image.toJSON()
          success: (response)->
            that.images.remove that.iamge
          error: (response)->
            console.log response

      addTag: (e)->
        that = this
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        args = 
          parent: that
          taggable: 'imageTags'
          placeholder: "add tag for #{that.image.get('fileName')}"
        @buildTagPanel(args)

      removeTag: (e)->
        that = this
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        console.log 'removeTag'
        tags = that.image.get('tags') || []
        existed = tags.indexOf($e.data('name'))
        if existed >= 0
          tags.splice(existed,1)
        that.image.set tags: tags
        @$('.tags').html that.buildTagTokensHtml(tags)
        @updateImage()

      afterAddTag: (options)->
        that = this
        tags = that.image.get('tags') || []
        if tags.indexOf(options.name) < 0
          tags.push options.name
        that.image.set(tags: tags)
        that.updateImage()
        @$('.tags').html that.buildTagTokensHtml(tags)

      buildTagTokensHtml: (tags)->
        tpl = """
          <% _.each(tags, function(name){ %>
            <div class="token left">
                <%= name %> &nbsp; <i class="fi-x removeTag" data-name="<%= name %>"></i>
            </div>
          <% }) %>
        """
        html = _.template(tpl, {_: _, tags: tags})
        return html

      buildTagPanel: (options)->
        that = this
        view = new TagView(options)
        that.tagView = view
        $('.listImages').append(view.render().el)
        $('.listImages .list-images').addClass('column large-8')
        $('.closeSlideout').show()

      updateImage: ()->
        isNew = @image.isNew()
        if @image.isValid()
          @image.url = '/api/images/update'

          @image.save @image.toJSON(),
            success: (model, response, options)->
              console.log 'saved'

            error: (model, response, options)->
              console.log 'errror'
              console.log response

      initialize: (options)->
        @options = options
        @image = options.image
        @images = options.images
        
      render: ()->
        that = this
        tpl = _.template(ImageTemplate, {_: _, image: @image.toJSON()})
        @$el.html(tpl)
        @

    )
    return ListImagesView

)          