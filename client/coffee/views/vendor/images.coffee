define([
  'jq'
  'underscore'
  'Backbone'
  'models/room'
  'collections/rooms'
  'views/shared/alert_message'
  'views/vendor/rooms/room'
  'text!templates/vendor/images.html'
], ($
    _
    Backbone
    RoomModel
    RoomsCollection
    AlertMessage
    RoomView
    VendorImagesTemplate
  )->

    VendorImagesView = Backbone.View.extend(
      el: '#setupContent'

      events:
        'click .addNewRoom': 'addNewRoom'
        'click .menu-list li.item a': 'selectRoom'

      render: ()->
        that = this
        tpl = _.template(VendorImagesTemplate, {})
        @$el.html(tpl)
        @

    )
    return VendorImagesView

)  