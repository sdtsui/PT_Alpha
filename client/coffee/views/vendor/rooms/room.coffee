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
      
      events:
        'click .menu-wrap.menu-secondary li a': 'switchMenu'

      switchMenu: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        $e.closest('ul').find('li').removeClass('active')
        $e.closest('li').addClass('active')
        switch $e.data('nav')
          when 'general'
            @buildGeneral()
          when 'layouts'
            @buildLayouts()
          when 'revenue'
            @buildRevenue()
          when 'amenities'
            @buildAmenities()
          when 'services'
            @buildServices
          when 'menu'
            @buildMenus()
          when 'marketing'
            @buildMarketing()

      initialize: (options)->
        @room = options.room
        @rooms = options.rooms

      buildGeneral: ()->
        view = new RoomGeneralView({room: @room, rooms: @rooms})
        @$('.roomContent').html view.render().el

      buildLayouts: ()->
        view = new RoomLayoutsView({room: @room})
        @$('.roomContent').html view.render().el

      buildRevenue: ()->
        view = new RoomRevenueView({room: @room})
        @$('.roomContent').html view.render().el

      buildAmenities: ()->
        view = new RoomAmenitiesView({room: @room})
        @$('.roomContent').html view.render().el

      buildServices: ()->
        view = new RoomServicesView({room: @room})
        @$('.roomContent').html view.render().el

      buildMenus: ()->
        view = new RoomMenusView({room: @room})
        @$('.roomContent').html view.render().el

      buildMarketing: ()->
        view = new RoomMarketingView({room: @room})
        @$('.roomContent').html view.render().el

      render: ()->
        that = this
        tpl = _.template(RoomTemplate, {_: _, room: @room})
        @$el.html(tpl)
        @buildGeneral()
        @

    )
    return RoomView

)      