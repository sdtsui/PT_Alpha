define([
  'jq'
  'underscore'
  'Backbone'
  'models/room'
  'collections/rooms'
  'views/shared/alert_message'
  'views/vendor/rooms/room'
  'text!templates/vendor/rooms.html'
], ($
    _
    Backbone
    RoomModel
    RoomsCollection
    AlertMessage
    RoomView
    VendorRoomsTemplate
  )->

    VendorRoomsView = Backbone.View.extend(
      el: '#setupContent'

      events:
        'click .addNewRoom': 'addNewRoom'
        'click .menu-list li.item a': 'selectRoom'

      addNewRoom: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @formRoom = new RoomModel()
        @buildRoom()

      selectRoom: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @formRoom = @rooms.get $e.data('room_id')
        @buildRoom()

      buildRoom: ()->
        view = new RoomView({room: @formRoom, rooms: @rooms})
        @$('.vendorRooms').html view.render().el


      initialize: (options)->
        that = this
        @rooms = new RoomsCollection()
        @rooms.fetch()
        @formRoom = new RoomModel()
        @rooms.on 'add', (s)->
          that.buildRooms()
        @rooms.on 'remove', (s)->
          console.log that.rooms
          that.buildRooms()

      buildRoomsList: ()->
        that = this
        @rooms.fetch
          success: (collections, response, options)->
            that.buildRooms()

      buildRooms: ()->
        that = this

        tpl = """
          <% _.each(rooms, function(room){
          %>
            <li class="item" >
              <a data-room_id="<%= room._id %>"> <%= room.name %></a>
            </li>
          <%
            });
          %>
        """
        html = _.template(tpl, {_: _, rooms: @rooms.toJSON()})
        @$('.menu-list').html(html)

      render: ()->
        that = this
        console.log that
        tpl = _.template(VendorRoomsTemplate, {})
        @$el.html(tpl)
        @buildRoomsList()
        @

    )
    return VendorRoomsView

)    