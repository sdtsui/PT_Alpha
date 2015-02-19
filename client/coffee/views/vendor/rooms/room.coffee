define([
  'jq'
  'underscore'
  'Backbone'
  'views/shared/alert_message'
  'views/vendor/rooms/general'
  'views/vendor/rooms/layouts'
  'views/vendor/rooms/revenue'
  'views/vendor/rooms/amenities'
  'views/vendor/rooms/services'
  'views/vendor/rooms/menus'
  'views/vendor/rooms/marketing'
  'text!templates/vendor/rooms/room.html'
], ($
    _
    Backbone
    AlertMessage
    RoomGeneralView
    RoomLayoutsView
    RoomRevenueView
    RoomAmenitiesView
    RoomServicesView
    RoomMenusView
    RoomMarketingView
    RoomTemplate
  )->
    RoomView = Backbone.View.extend(
      tagName: 'div'
      className: 'row'


      initialize: (options)->
        @room = options.room

      buildGeneral: ()->
        view = new RoomGeneralView({room: @room})
        @$('.form-wrap').html view.render().el

      buildLayouts: ()->
        view = new RoomLayoutsView({})
        @$('.form-wrap').html view.render().el

      buildRevenue: ()->
        view = new RoomRevenueView({})
        @$('.form-wrap').html view.render().el

      buildAmenities: ()->
        view = new RoomAmenitiesView({})
        @$('.form-wrap').html view.render().el

      buildServices: ()->
        view = new RoomServicesView({})
        @$('.form-wrap').html view.render().el

      buildMenus: ()->
        view = new RoomMenusView({})
        @$('.form-wrap').html view.render().el

      buildMarketing: ()->
        view = new RoomMarketingView({})
        @$('.form-wrap').html view.render().el

      render: ()->
        that = this
        tpl = _.template(RoomTemplate, {_: _})
        @$el.html(tpl)
        @buildGeneral()
        @

    )
    return RoomView

)      