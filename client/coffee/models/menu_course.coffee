define([
  'underscore'
  'Backbone'
], (_, Backbone)->
  MenuCourseModel = Backbone.Model.extend(
    idAttribute: "_id"
    defaults:
      name: ''
      menuItems: []
      
    url: '/api/courses'

    initialize: (options)->
      that = this
      if options && options.menu
        that.set menu: options.menu.get('_id')

  )

  return MenuCourseModel

)
