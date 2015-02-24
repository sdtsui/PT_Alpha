define([
  'jquery'
  'underscore'
  'Backbone'
  'views/shared/alert_message'
  'text!templates/vendor/setup/search_terminology.html'
], ($
    _
    Backbone
    AlertMessage
    SearchTeminologyTemplate
  )->

    SearchTerminologyView = Backbone.View.extend(

      tagName: 'div'
      className: 'columns large-4 left-col searchTerminology'
      events:
        'change .searchQuery': 'searchQuery'
        'click .addNewType': 'addNewType'
        'click i.addItem': 'addItem'
        'click .saveRole': 'saveRole'
        'click .deleteRole': 'deleteRole'

      addNewType: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        name = @$('input[name="query"]').val()
        if !name 
          return
        @addItemInServer(name)

      addItem: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @addItemInServer($e.data('name'))

      addItemInServer: (name)->
        that = this
        $.ajax
          url: '/api/terminologies/add'
          method: 'POST'
          datatype: 'json'
          data: {name: name, kind: @type}
          success: (response)->
            that.parent.setting = response
            that.parent.buildHtml()
          error: (response)->
            msg = new AlertMessage({messages: ["There are some errors"]})
            that.$el.prepend(msg.render().el)

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
          url: '/api/terminologies/search'
          method: 'GET'
          datatype: 'json'
          data: {name: term, kind: @type}
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
        tpl = _.template(SearchTeminologyTemplate, {_: _, displayType: @displayType()})
        @$el.html(tpl)
        @$('input[name="query"]').focus()
        @buildSearchResults([])
        @
    )
    return SearchTerminologyView
)