define([
  'jq'
  'underscore'
  'Backbone'
  'collections/menus'
  'views/shared/alert_message'
  'text!templates/vendor/rooms/menus.html'
], ($
    _
    Backbone
    MenusCollection
    AlertMessage
    RoomMenusTemplate
  )->
    RoomMenusView = Backbone.View.extend(
      tagName: 'div'
      className: 'row'

      events:
        'click .toggleMenu': 'toggleMenu'


      toggleMenu: (e)->
        $e = $(e.currentTarget)
        menus = @room.get('menus') || []
        existed = menus.indexOf($e.data('id'))
        if existed >=0
          menus.splice(existed, 1)
        else
          menus.push $e.data('id')

        @room.set menus: menus
        @updateRoom()

      updateRoom: ()->
        that = this
        @room.url = '/api/rooms/update'

        @room.save @room.toJSON(),
          success: (model, response, options)->
            console.log 'updated success'
          error: (model, response, options)->
            console.log 'error'
            console.log response
            msg = new AlertMessage({messages: ["There are some errors"]})
            that.$el.prepend(msg.render().el)        

      initialize: (options)->
        @room = options.room
        @menus = new MenusCollection()
        @menus.url = '/api/menus'


      buildHtml: ()->
        that = this
        tpl = _.template(RoomMenusTemplate, {_: _, room: @room.toJSON(), menus: @menus.toJSON()})
        @$el.html(tpl)        

      render: ()->
        that = this
        that.menus.fetch 
          success: (collections, response, options)->
            that.buildHtml()
        @

    )
    return RoomMenusView

)      