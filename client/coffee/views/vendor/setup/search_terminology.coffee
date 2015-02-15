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
        'blur .searchQuery': 'searchQuery'
        'click .addNewType': 'addNewType'
        'click .saveRole': 'saveRole'
        'click .deleteRole': 'deleteRole'

      addNewType: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        name = @$('input[name="query"]').val()
        console.log name
        console.log @type
      
      searchQuery: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        name = @$('input[name="query"]').val()
        console.log name
        console.log @type
        @searchTerm(name)
      
      initialize: (options)->
        @options = options
        @type = options.type


      searchTerm: (term)->
        that = this
        $.ajax
          url: '/api/terminologies/search'
          method: 'GET'
          datatype: 'json'
          data: {name: term, kind: @type}
          success: (response)->
            console.log response
            that.buildSearchResults(response)
          error: (response)->
            msg = new AlertMessage({messages: ["There are some errors"]})
            that.$el.prepend(msg.render().el)

      buildSearchResults: (items)->
        tpl = """
          <% _.each(items, function(item){%>
            <li class="item">
                <%= item.name %> <i class="fi-plus right addItem"></i>
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