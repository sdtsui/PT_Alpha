define([
  'jq'
  'underscore'
  'Backbone'
  'views/shared/alert_message'
  'text!templates/vendor/rooms/general.html'
], ($
    _
    Backbone
    AlertMessage
    RoomGeneralTemplate
  )->
    RoomGeneralView = Backbone.View.extend(
      tagName: 'div'
      className: 'row'


      initialize: (options)->
        @room = options.room
        console.log @room

      render: ()->
        that = this
        tpl = _.template(RoomGeneralTemplate, {_: _})
        console.log tpl
        @$el.html(tpl)
        @

    )
    return RoomGeneralView

)      