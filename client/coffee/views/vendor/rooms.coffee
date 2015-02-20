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

      addNewRoom: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @buildRoom(@formRoom)

      buildRoom: (room)->
        view = new RoomView({room: room, rooms: @rooms})
        @$('.vendorRooms').html view.render().el


      initialize: (options)->
        @rooms = new RoomsCollection()
        @rooms.fetch()
        @formRoom = new RoomModel()

      render: ()->
        that = this
        console.log that
        tpl = _.template(VendorRoomsTemplate, {})
        @$el.html(tpl)
        @

    )
    return VendorRoomsView

)    