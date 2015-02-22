define([
  'jq'
  'underscore'
  'Backbone'
  'models/room_layout'
  'collections/room_layouts'
  'views/shared/alert_message'
  'views/vendor/rooms/form_layout'
  'text!templates/vendor/rooms/layouts.html'
], ($
    _
    Backbone
    RoomLayoutModel
    RoomLayoutsCollection
    AlertMessage
    FormLayoutView
    RoomLayoutsTemplate
  )->
    RoomLayoutsView = Backbone.View.extend(
      tagName: 'div'
      className: 'row'

      events:
        'click .addNewLayout': 'addNewLayout'
        'click .menu-list li.item a': 'selectLayout'

      addNewLayout: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        console.log $e
        @formLayout = new RoomLayoutModel()
        @buildFormLayout()

      selectLayout: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @formLayout = @layouts.get($e.data('layout_id'))
        @buildFormLayout()

      buildFormLayout: ()->
        view = new FormLayoutView({formLayout: @formLayout, layouts: @layouts})
        @$('.layoutContent').html view.render().el 

      buildLayoutsList: ()->
        that = this
        @layouts.fetch
          success: (collections, response, options)->
            that.buildLayouts()

      buildLayouts: ()->
        that = this

        tpl = """
          <% _.each(layouts, function(layout){
          %>
            <li class="item" >
              <a data-layout_id="<%= layout._id %>"> <%= layout.name %></a>
            </li>
          <%
            });
          %>
        """
        html = _.template(tpl, {_: _, layouts: @layouts.toJSON()})
        @$('.menu-list').html(html)

      initialize: (options)->
        @room = options.room
        console.log @room
        @layouts = new RoomLayoutsCollection({room: @room.id})
        @layouts.fetch()
        @formLayout = new RoomLayoutModel()

      render: ()->
        that = this
        tpl = _.template(RoomLayoutsTemplate, {_: _})
        @$el.html(tpl)
        @buildLayoutsList()
        @

    )
    return RoomLayoutsView

)