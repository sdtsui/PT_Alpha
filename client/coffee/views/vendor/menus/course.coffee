define([
  'jq'
  'underscore'
  'Backbone'
  'models/menu_course'
  'views/shared/alert_message'
  'text!templates/vendor/menus/course.html'
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
        'click .saveCourse': 'saveCourse'
        'click .cancelCourse': 'cancelCourse'

      saveCourse: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        console.log @course.toJSON()
        
      cancelCourse: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @$el.remove()


      initialize: (options)->
        @options = options
        @course = options.course

      bindingDom: ()->
        @$name = @$('input[name="name"')
        @$name.on 'blur', =>
          @course.set name: @$name.val()


      buildFormHtml: ()->
        that = this
        tpl = _.template(FormCourseTemplate, {
                _: _
                isNew: @course.isNew()
                course: @course.toJSON()
              })
        @$el.html(tpl)
        @bindingDom()     

      buildHtml: ()->

      render: ()->
        if @course.isNew()
          @buildFormHtml()
        else
          @buildHtml()
        @

    )
    return MenuCoursesView

)        