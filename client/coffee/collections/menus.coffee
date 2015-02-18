define([
  'jquery',
  'underscore'
  'Backbone'
  'models/menu'
], ($, _, Backbone, MenuItemModel)->
  MenusCollection = Backbone.Collection.extend(
    model: MenuItemModel,
    initialize: (options)->
      console.log options
    url: '/api/menus'
  )
  return MenusCollection
)
