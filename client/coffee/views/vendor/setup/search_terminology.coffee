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
        'click .addNewType': 'addNewType'
        'click .saveRole': 'saveRole'
        'click .deleteRole': 'deleteRole'

      addNewType: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        name = @$('input[name="query"]').val()
      
      initialize: (options)->
        @options = options
        @type = options.type

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
        @buildSearchResults([])
        @
    )
    return SearchTerminologyView
)