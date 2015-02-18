define([
  'jq'
  'underscore'
  'Backbone'
  'models/menu'
  'views/shared/alert_message'
  'text!templates/vendor/menus/form.html'
], ($
    _
    Backbone
    MenuModel
    AlertMessage
    FormMenuTemplate
  )->
    FormMenuItemsView = Backbone.View.extend(
      tagName: 'div'
      className: 'row'
      events:
        'click .deleteMenu': 'deleteMenu'
        'click .cancelMenu': 'cancelMenu'
        'click .saveMenu': 'saveMenu'

      deleteMenu: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @$el.remove()

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

      bindingDom: ()->
        @$name = @$('input[name="name"]')
        @$name.on 'blur', => 
          @formMenu.set name: @$name.val()

        @$pricePerHead = @$('input[name="pricePerHead"]')
        @$pricePerHead.on 'blur', => 
          @formMenu.set pricePerHead: @$pricePerHead.val()       

        @$productType = @$('select[name="productType"]')
        @$productType.on 'change', => 
          @formMenu.set productType: @$productType.val()       

        @$isActive = @$('input[name="isActive"]')
        @$isActive.on 'click', => 
          @formMenu.set isActive: @$isActive.is(':checked')



      render: ()->
        that = this
        tpl = _.template(FormMenuTemplate, {_: _, menu: that.formMenu.toJSON()})
        @$el.html(tpl)
        @bindingDom()
        @

    )
    return FormMenuItemsView

)