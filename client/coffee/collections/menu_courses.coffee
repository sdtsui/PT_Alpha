define([
  'jquery',
  'underscore'
  'Backbone'
  'models/menu_course'
], ($, _, Backbone, MenuCourseModel)->
  MenuCoursesCollection = Backbone.Collection.extend(
    model: MenuCourseModel,
    initialize: (options)->
      console.log options
    url: '/api/menu_courses'
  )
  return MenuCoursesCollection
)
