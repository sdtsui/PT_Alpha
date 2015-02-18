define([
  'jq'
  'underscore'
  'Backbone'
  'views/shared/alert_message'
  'text!templates/vendor/rooms/revenue.html'
], ($
    _
    Backbone
    AlertMessage
    RoomRevenueTemplate
  )->
    RoomRevenueView = Backbone.View.extend(
      tagName: 'div'
      className: 'row'


      initialize: (options)->
        @room = options.room
        

      render: ()->
        that = this
        tpl = _.template(RoomRevenueTemplate, {_: _})
        @$el.html(tpl)
        @

    )
    return RoomRevenueView

)      