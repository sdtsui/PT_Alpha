define([
  'jq'
  'underscore'
  'Backbone'
  'views/shared/alert_message'
  'views/shared/tag'
  'text!templates/vendor/rooms/marketing.html'
], ($
    _
    Backbone
    AlertMessage
    TagView
    RoomMarketingTemplate
  )->
    RoomMarketingView = Backbone.View.extend(
      tagName: 'div'
      className: 'row'

      events:
        'click .addTag': 'addTag'
        'click .room-tokens .removeTag': 'removeTag'

      addTag: (e)->
        that = this
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        view = new TagView({parent: that, taggable: 'marketing'})
        @$el.append(view.render().el)

      removeTag: (e)->
        that = this
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        marketing = that.room.get('marketing') || []
        existed = marketing.indexOf($e.data('name'))
        console.log existed
        if existed >= 0
          marketing.splice(existed,1)
        that.room.set marketing: marketing
        that.$('.room-tokens').html that.buildTagTokensHtml(marketing)
        @updateRoom()

      updateRoom: ()->
        that = this
        @room.url = '/api/rooms/update'

        @room.save @room.toJSON(),
          success: (model, response, options)->
            msg = new AlertMessage({type: 'success', messages: ["Marketing tag was saved successfully."]})
            that.$el.prepend(msg.render().el)

          error: (model, response, options)->
            console.log 'errror'
            console.log response
            msg = new AlertMessage({messages: ["There are some errors"]})
            that.$el.prepend(msg.render().el)               


      afterAddTag: (options)->
        that = this
        marketing = @room.get('marketing') || []
        marketing.push(options.name)
        @room.set marketing: marketing
        @$('.room-tokens').html that.buildTagTokensHtml(marketing)
        @updateRoom()

      initialize: (options)->
        @room = options.room

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

      render: ()->
        that = this
        tpl = _.template(RoomMarketingTemplate, {_: _, room: @room.toJSON()})
        @$el.html(tpl)
        @

    )
    return RoomMarketingView

)      