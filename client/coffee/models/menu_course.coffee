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
      console.log 'new MenuCourseModel'

  )

  return MenuCourseModel

)
