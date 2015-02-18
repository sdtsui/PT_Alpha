define([
  'jquery',
  'underscore'
  'Backbone'
  'models/menu'
], ($, _, Backbone, MenuModel)->
  MenusCollection = Backbone.Collection.extend(
    model: MenuModel,
    initialize: (options)->
      console.log options
    url: '/api/menus'
  )
  return MenusCollection
)
