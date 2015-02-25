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
      className: 'columns large-4 left-col searchTerminology'
      events:
        'change .searchQuery': 'searchQuery'
        'click i.addItem': 'addItem'

      addItem: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        console.log 'addItem'

      searchQuery: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        name = @$('input[name="query"]').val()
        @searchTerm(name)
      
      initialize: (options)->
        @options = options
        @type = options.type
        @parent = options.parent

      searchTerm: (term)->
        that = this
        $.ajax
          url: '/api/tags/search'
          method: 'GET'
          datatype: 'json'
          data: {name: term, taggable: @type}
          success: (response)->
            that.buildSearchResults(response)
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
        switch @type
          when 'roomType'
            'room type'
          when 'courseType'
            'course type'
          when 'jobRoleType'
            'job role type'
          when 'ammenityType'
            'ammenity type'
          else
            @type


      render: ()->
        tpl = _.template(TagTemplate, {_: _, displayType: @displayType()})
        @$el.html(tpl)
        @$('input[name="query"]').focus()
        @buildSearchResults([])
        @
    )
    return TagView
)