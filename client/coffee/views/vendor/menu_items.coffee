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

      addNewMenuItem: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @buildItemForm()

      buildItemForm: ()->
        view = new FormMenuItemView({items: @items, formItem: @formItem})
        @$('.form-wrap').html view.render().el

      initialize: (options)->
        @items = new MenuItemsCollection()
        @formItem = new MenuItemModel()

      render: ()->
        that = this
        tpl = _.template(MenuItemsTemplate, {})
        @$el.html(tpl)
        @

    )
    return MenuItemsView

)