define([
  'jq'
  'underscore'
  'Backbone'
  'views/shared/alert_message'
  'text!templates/vendor/rooms/marketing.html'
], ($
    _
    Backbone
    AlertMessage
    RoomMarketingTemplate
  )->
    RoomMarketingView = Backbone.View.extend(
      tagName: 'div'
      className: 'row'


      initialize: (options)->
        @room = options.room
        

      render: ()->
        that = this
        tpl = _.template(RoomMarketingTemplate, {_: _})
        @$el.html(tpl)
        @

    )
    return RoomMarketingView

)      