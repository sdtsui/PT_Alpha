define([
  'jq'
  'underscore'
  'Backbone'
  'models/menu_course'
  'collections/menu_courses'
  'views/shared/alert_message'
  'text!templates/vendor/menus/courses.html'
], ($
    _
    Backbone
    MenuCourseModel
    MenuCoursesViewCollection
    AlertMessage
    MenuCoursesTemplate
  )->
    MenuCoursesView = Backbone.View.extend(
      tagName: 'div'
      className: 'row'
      events:
        'click .deleteMenu': 'deleteMenu'
        'click .cancelMenu': 'cancelMenu'
        'click .saveMenu': 'saveMenu'

      initialize: (options)->
        @options = options

      render: ()->
        that = this
        tpl = _.template(MenuCoursesTemplate, {
                _: _
              })
        @$el.html(tpl)
        @

    )
    return MenuCoursesView

)        