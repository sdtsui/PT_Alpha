define([
  'underscore'
  'Backbone'
], (_, Backbone)->
  MenuCourseModel = Backbone.Model.extend(
    idAttribute: "_id"
    defaults:
      name: ''
      menuItems: []
      
    initialize: (options)->
      that = this
      if that.isNew() && options && options.menu
        that.set menu: options.menu.id

      that

  )

  return MenuCourseModel

)
