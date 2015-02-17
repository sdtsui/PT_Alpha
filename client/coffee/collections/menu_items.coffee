define([
  'jquery',
  'underscore'
  'Backbone'
  'models/menu_item'
], ($, _, Backbone, MenuItemModel)->
  MenuItemsCollection = Backbone.Collection.extend(
    model: MenuItemModel,
    initialize: (options)->
      console.log options
    url: '/api/menu_items'
  )
  return MenuItemsCollection
)
