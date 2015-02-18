define([
  'jq'
  'underscore'
  'Backbone'
  'models/venue'
  'models/menu_item'
  'collections/menu_items'
  'views/shared/alert_message'
  'views/vendor/menu_items/form_item'
  'text!templates/vendor/menu_items.html'
], ($
    _
    Backbone
    VenueModel
    MenuItemModel
    MenuItemsCollection
    AlertMessage
    FormMenuItemView
    MenuItemsTemplate
  )->
    MenuItemsView = Backbone.View.extend(
      el: '#setupContent'
      events:
        'click .addNewMenuItem': 'addNewMenuItem'
        'click .menu-list li.item a': 'selectMenuItem'

      addNewMenuItem: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @buildItemForm()

      selectMenuItem: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @formItem = @items.get($e.data('item_id'))
        console.log $e.data('item_id')
        console.log @formItem
        @buildItemForm()


      buildItemForm: ()->
        view = new FormMenuItemView({items: @items, formItem: @formItem})
        @$('.form-wrap').html view.render().el

      initialize: (options)->
        @items = new MenuItemsCollection()
        @formItem = new MenuItemModel()

      buildMenuItems: ()->
        that = this

        tpl = """
          <% _.each(items, function(item){
          %>
            <li class="item" >
              <a data-item_id="<%= item._id %>"> <%= item.name %></a>
            </li>
          <%
            });
          %>
        """
        html = _.template(tpl, {_: _, items: @items.toJSON()})
        @$('.menu-list').html(html)

      render: ()->
        that = this
        tpl = _.template(MenuItemsTemplate, {})
        @$el.html(tpl)
        that.items.fetch 
          success: (collections, response, options)->
            that.buildMenuItems()
        @

    )
    return MenuItemsView

)