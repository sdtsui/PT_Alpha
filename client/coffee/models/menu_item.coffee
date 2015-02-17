define([
  'underscore'
  'Backbone'
], (_, Backbone)->
  MenuItemModel = Backbone.Model.extend(
    idAttribute: "_id"
    defaults:
      name: ''
      description: ''
      subcategory: ''
      price:
        value: 0
        unit: ''
      guest:
        countRequired: true
        countValue: 0
      ingredients: []
      dietaryPreferences: []
      isActive: true
    
    url: '/api/menu_item'

    initialize: (options)->
      console.log 'new MenuItemModel'

  )

  return MenuItemModel

)
