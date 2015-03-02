define([
  'jq'
  'underscore'
  'Backbone'
  'models/menu_course'
  'views/shared/alert_message'
  'text!templates/vendor/menus/form_course.html'
], ($
    _
    Backbone
    MenuCourseModel
    AlertMessage
    FormCourseTemplate
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
        tpl = _.template(FormCourseTemplate, {
                _: _
              })
        @$el.html(tpl)
        @

    )
    return MenuCoursesView

)        