define([
  'jq'
  'underscore'
  'Backbone'
  'views/shared/alert_message'
  'text!templates/vendor/rooms/amenities.html'
], ($
    _
    Backbone
    AlertMessage
    RoomAmenitiesTemplate
  )->
    RoomAmenitiesView = Backbone.View.extend(
      tagName: 'div'
      className: 'row'


      initialize: (options)->
        @room = options.room
        

      render: ()->
        that = this
        tpl = _.template(RoomAmenitiesTemplate, {_: _})
        @$el.html(tpl)
        @

    )
    return RoomAmenitiesView

)      