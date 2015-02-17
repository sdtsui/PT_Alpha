define([
  'jq'
  'underscore'
  'Backbone'
  'models/venue'
  'models/menu_item'
  'collections/menu_items'
  'views/shared/alert_message'
  'text!templates/vendor/menu_items.html'
], ($
    _
    Backbone
    VenueModel
    MenuItemModel
    MenuItemsCollection
    AlertMessage
    MenuItemsTemplate
  )->
    MenuItemsView = Backbone.View.extend(
      el: '#setupContent'

      render: ()->
        that = this
        tpl = _.template(MenuItemsTemplate, {})
        @$el.html(tpl)
        @

    )
    return MenuItemsView

)