define([
  'jq'
  'underscore'
  'Backbone'
  'views/shared/alert_message'
  'text!templates/vendor/rooms/menus.html'
], ($
    _
    Backbone
    AlertMessage
    RoomMenusTemplate
  )->
    RoomMenusView = Backbone.View.extend(
      tagName: 'div'
      className: 'row'


      initialize: (options)->
        @room = options.room
        

      render: ()->
        that = this
        tpl = _.template(RoomMenusTemplate, {_: _})
        @$el.html(tpl)
        @

    )
    return RoomMenusView

)      