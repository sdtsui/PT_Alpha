define([
  'jq'
  'underscore'
  'Backbone'
  'views/shared/alert_message'
  'text!templates/vendor/rooms/layouts.html'
], ($
    _
    Backbone
    AlertMessage
    RoomLayoutsTemplate
  )->
    RoomLayoutsView = Backbone.View.extend(
      tagName: 'div'
      className: 'row'


      initialize: (options)->
        @room = options.room
        

      render: ()->
        that = this
        tpl = _.template(RoomLayoutsTemplate, {_: _})
        @$el.html(tpl)
        @

    )
    return RoomLayoutsView

)