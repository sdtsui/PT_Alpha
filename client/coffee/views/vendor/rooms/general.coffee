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

      bindingDom: ()->


      render: ()->
        that = this
        tpl = _.template(RoomGeneralTemplate, {_: _, room: {} })
        console.log tpl
        @$el.html(tpl)
        @bindingDom()
        @

    )
    return RoomGeneralView

)      