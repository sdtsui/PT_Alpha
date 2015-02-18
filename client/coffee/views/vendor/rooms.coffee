define([
  'jq'
  'underscore'
  'Backbone'
  'views/shared/alert_message'
  'views/vendor/rooms/room'
  'text!templates/vendor/rooms.html'
], ($
    _
    Backbone
    AlertMessage
    RoomView
    VendorRoomsTemplate
  )->

    VendorRoomsView = Backbone.View.extend(
      # tagName: 'div'
      # className: 'sticky'
      el: '#setupContent'

      events:
        'click .addNewRoom': 'addNewRoom'

      addNewRoom: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        console.log 'aaaa'
        @buildRoom()

      buildRoom: ()->
        view = new RoomView({room: null})
        @$('.vendorRooms').html view.render().el


      render: ()->
        that = this
        console.log that
        tpl = _.template(VendorRoomsTemplate, {})
        @$el.html(tpl)
        @

    )
    return VendorRoomsView

)    