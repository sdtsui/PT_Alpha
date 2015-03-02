define([
  'jq'
  'underscore'
  'Backbone'
  'models/menu_course'
  'views/shared/alert_message'
  'text!templates/vendor/menus/form_course.html'
  'text!templates/vendor/menus/course.html'
], ($
    _
    Backbone
    MenuCourseModel
    AlertMessage
    FormCourseTemplate
    CourseTemplate
  )->
    MenuCoursesView = Backbone.View.extend(
      tagName: 'div'
      className: 'row'
      events:
        'click .saveCourse': 'saveCourse'
        'click .cancelCourse': 'cancelCourse'

      saveCourse: (e)->
        that = this
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        console.log @course.toJSON()
        
        isNew = @course.isNew()
        if isNew
          @course.url = "/api/menu_courses/add"
        else
          @course.url = "/api/menu_courses/update"


        @course.save @course.toJSON(),
          success: (model, response, options)->
            that.displayHtml()
          error: (model, response, options)->
            console.log 'errror'
            console.log response
            msg = new AlertMessage({messages: ["There are some errors"]})
            that.$el.prepend(msg.render().el)        


      cancelCourse: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @$el.remove()


      initialize: (options)->
        @options = options
        @course = options.course
        @holder = @course.clone()

      bindingDom: ()->
        @$name = @$('input[name="name"]')
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

      displayHtml: ()->
        that = this
        tpl = _.template(CourseTemplate, {
                _: _
                course: @course.toJSON()
              })
        @$el.html(tpl)

      buildHtml: ()->
        if @course.isNew()
          @buildFormHtml()
        else
          @displayHtml()

      render: ()->
        @buildHtml()
        @

    )
    return MenuCoursesView

)        