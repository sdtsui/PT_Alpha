define([
  'underscore'
  'Backbone'
], (_, Backbone)->
  MenuModel = Backbone.Model.extend(
    idAttribute: "_id"
    defaults:
      name: ''
      price:
        value: 0
        unit: ''
      productType: ''
      isActive: true
      
    url: '/api/menu_item'

    initialize: (options)->
      console.log 'new MenuModel'

  )

  return MenuModel

)
