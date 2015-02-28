define([
  'jquery'
  'underscore'
  'Backbone'
  'views/shared/alert_message'
  'text!templates/shared/tag.html'
], ($
    _
    Backbone
    AlertMessage
    TagTemplate
  )->

    TagView = Backbone.View.extend(

      tagName: 'div'
      className: 'columns large-4 left-col boxTag'
      events:
        'change .searchQuery': 'searchQuery'
        'click i.addItem': 'addItem'
        'click .addNewTag': 'addNewTag'
        'click .closeTagBox': 'closeTagBox'

      closeTagBox: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @$el.remove()
        $('.dualTagBox').removeClass('column large-8')

      addNewTag: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        query = @$('input[name="query"]').val()
        if !query
          return
        @addTermToServer(query)
        if @parent.afterAddTag && typeof @parent.afterAddTag == 'function'
          @parent.afterAddTag({name: query, taggable: @taggable})
        
        @$('input[name="query"]').val('')

      addItem: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        if @parent.afterAddTag && typeof @parent.afterAddTag == 'function'
          @parent.afterAddTag({name: $e.data('name'), taggable: @taggable})

      searchQuery: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        name = @$('input[name="query"]').val()
        if !name
          return
        @searchTerm(name)
      
      initialize: (options)->
        @options = options
        @taggable = options.taggable
        @parent = options.parent
        @placeholder = options.placeholder

      searchTerm: (term)->
        that = this
        $.ajax
          url: '/api/tags/search'
          method: 'GET'
          datatype: 'json'
          data: {name: term, taggable: that.taggable}
          success: (response)->
            that.buildSearchResults(response)
          error: (response)->
            msg = new AlertMessage({messages: ["There are some errors"]})
            that.$el.prepend(msg.render().el)

      addTermToServer: (term)->
        that = this
        $.ajax
          url: '/api/tags/add'
          method: 'POST'
          datatype: 'json'
          data: {name: term, taggable: that.taggable}
          success: (response)->
            console.log response
          error: (response)->
            msg = new AlertMessage({messages: ["There are some errors"]})
            that.$el.prepend(msg.render().el)

      buildSearchResults: (items)->
        tpl = """
          <% _.each(items, function(item){%>
            <li class="item">
                <%= item.name %> <i class="fi-plus right addItem" data-name="<%= item.name %>"></i>
            </li>
          <% });%>
        """

        html = _.template(tpl, {_: _, items: items})
        @$('.menu-list').html(html)


      displayType: ()->
        switch @taggable
          when 'roomType'
            'room type'
          when 'courseType'
            'course type'
          when 'jobRoleType'
            'job role type'
          when 'ammenityType'
            'ammenity type'
          else
            (@placeholder || @taggable)


      render: ()->
        $('.boxTag').remove()
        tpl = _.template(TagTemplate, {_: _, displayType: @displayType()})
        @$el.html(tpl)
        @$('input[name="query"]').focus()
        $('.dualTagBox').addClass('column large-8')
        @buildSearchResults([])
        @
    )
    return TagView
)