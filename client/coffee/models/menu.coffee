define([
  'underscore'
  'Backbone'
], (_, Backbone)->
  MenuModel = Backbone.Model.extend(
    idAttribute: "_id"
    defaults:
      name: ''
      pricePerHead: ''
      productType: ''
    
    url: '/api/menu_item'

    initialize: (options)->
      console.log 'new MenuModel'

  )

  return MenuModel

)
