define([
  'jq'
  'underscore'
  'Backbone'
  'models/venue'
  'models/menu_item'
  'collections/menus'
  'views/shared/alert_message'
  'views/vendor/menus/form_menu'
  'text!templates/vendor/menus.html'
], ($
    _
    Backbone
    VenueModel
    MenuItemModel
    MenuItemsCollection
    AlertMessage
    FormMenuView
    MenuTemplate
  )->
    MenuItemsView = Backbone.View.extend(
      el: '#setupContent'
      events:
        'click .addNewMenu': 'addNewMenu'
        'click .menu-list li.item a': 'selectMenu'

      addNewMenu: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @buildItemForm()

      selectMenu: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @formItem = @menus.get($e.data('menu_id'))
        console.log $e.data('menu_id')
        console.log @formItem
        @buildItemForm()


      buildItemForm: ()->
        view = new FormMenuView({menus: @menus, formItem: @formItem})
        @$('.form-wrap').html view.render().el

      initialize: (options)->
        that = this
        @menus = new MenuItemsCollection()
        @formItem = new MenuItemModel()
        @menus.on 'add', (s)->
          that.buildMenus()
        @menus.on 'remove', (s)->
          that.buildMenus()

      buildMenus: ()->
        that = this

        tpl = """
          <% _.each(menus, function(item){
          %>
            <li class="item" >
              <a data-menu_id="<%= item._id %>"> <%= item.name %></a>
            </li>
          <%
            });
          %>
        """
        html = _.template(tpl, {_: _, menus: @menus.toJSON()})
        @$('.menu-list').html(html)

      render: ()->
        that = this
        tpl = _.template(MenuTemplate, {})
        @$el.html(tpl)
        that.menus.fetch 
          success: (collections, response, options)->
            that.buildMenus()
        @

    )
    return MenuItemsView

)