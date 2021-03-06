define([
  'jq'
  'underscore'
  'Backbone'
  'models/menu'
  'models/menu_course'
  'collections/menu_courses'
  'views/shared/alert_message'
  'views/vendor/menus/menu_courses'
  'views/vendor/menus/course'
  'text!templates/vendor/menus/form.html'
], ($
    _
    Backbone
    MenuModel
    MenuCourseModel
    MenuCoursesCollection
    AlertMessage
    MenuCoursesView
    CourseView
    FormMenuTemplate
  )->
    FormMenuItemsView = Backbone.View.extend(
      tagName: 'div'
      className: 'row'
      events:
        'click .deleteMenu': 'deleteMenu'
        'click .cancelMenu': 'cancelMenu'
        'click .saveMenu': 'saveMenu'
        'click .addCourse': 'addCourse'

      deleteMenu: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @$el.remove()

      addCourse: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        console.log @formMenu
        course = new MenuCourseModel({menu: @formMenu})
        @buildCourse(course)
        
      cancelMenu: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @$el.remove()

      saveMenu: (e)->
        that = this
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        console.log @formMenu.toJSON()
        isNew = @formMenu.isNew()
        if @formMenu.isValid()
          if isNew
            @formMenu.url = '/api/menus/add'
          else
            @formMenu.url = '/api/menus/update'

          @formMenu.save @formMenu.toJSON(),
            success: (model, response, options)->
              if isNew
                that.menus.add that.formMenu
              msg = new AlertMessage({type: 'success', messages: ["Menu was saved successfully."]})
              that.$el.prepend(msg.render().el)

            error: (model, response, options)->
              console.log 'errror'
              console.log response
              msg = new AlertMessage({messages: ["There are some errors"]})
              that.$el.prepend(msg.render().el)        


      initialize: (options)->
        @formMenu = options.formMenu
        @menus = options.menus
        @courses = new MenuCoursesCollection()
        @initConstant()

      buildListCourses: ()->
        that = this
        if @formMenu.isNew()
          return
        @courses.url = "/api/menu_courses?menu=#{@formMenu.get('_id')}"

        @courses.fetch 
          success: (model, response, options)->
            that.courses.forEach (course)->
              that.buildCourse(course)

          error: (model, response, options)->
            msg = new AlertMessage({messages: ["There are some errors"]})
            that.$el.prepend(msg.render().el)        


      buildCourse: (course)->
        view = new CourseView({course: course})
        @$('.listCourses').prepend view.render().el


      initConstant: ()->
        @PRODUCT_TYPES =
          "banquet" : 'banquet'
          "reception" : 'reception'

        @PRICE_UNITS =
          HEAD: 'per head'
          TABLE: 'per table'

      bindingDom: ()->
        @$name = @$('input[name="name"]')
        @$name.on 'blur', => 
          @formMenu.set name: @$name.val()

        @$priceValue = @$('input[name="priceValue"]')
        @$priceValue.on 'blur', => 
          price = @formMenu.get('price') || {}
          price.value = @$priceValue.val()
          @formMenu.set price: price 

        @$priceUnit = @$('select[name="priceUnit"]')
        @$priceUnit.on 'change', => 
          price = @formMenu.get('price') || {}
          price.unit = @$priceUnit.val()
          @formMenu.set price: price

        @$productType = @$('select[name="productType"]')
        @$productType.on 'change', => 
          @formMenu.set productType: @$productType.val()       

        @$isActive = @$('input[name="isActive"]')
        @$isActive.on 'click', => 
          @formMenu.set isActive: @$isActive.is(':checked')


      render: ()->
        that = this
        tpl = _.template(FormMenuTemplate, {
                _: _
                isNew: that.formMenu.isNew()
                menu: that.formMenu.toJSON()
                PRODUCT_TYPES: @PRODUCT_TYPES
                PRICE_UNITS: @PRICE_UNITS
              })
        @$el.html(tpl)
        @bindingDom()
        @buildListCourses()

        @

    )
    return FormMenuItemsView

)