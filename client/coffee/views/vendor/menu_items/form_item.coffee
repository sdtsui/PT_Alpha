define([
  'jq'
  'underscore'
  'Backbone'
  'models/menu_item'
  'views/shared/alert_message'
  'text!templates/vendor/menu_items/form.html'
], ($
    _
    Backbone
    MenuItemModel
    AlertMessage
    FormMenuItemsTemplate
  )->
    FormMenuItemsView = Backbone.View.extend(
      tagName: 'div'
      className: 'row'
      events:
        'click .addNewMenuItem': 'addNewMenuItem'

      addNewMenuItem: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)


      initialize: (options)->
        @formItem = options.formItem
        @items = options.items

      bindingDom: ()->
        @$name = @$('input[name="name"]')
        @$name.on 'blur', => 
          @formItem.set name: @$name.val()

        @$description = @$('textarea[name="description"]')
        @$description.on 'change', => 
          @formItem.set description: @$description.val()

        @$subcategory = @$('select[name="subcategory"]')
        @$subcategory.on 'change', => 
          @formItem.set subcategory: @$subcategory.val()       

        @$isActive = @$('input[name="isActive"]')
        @$isActive.on 'click', => 
          @formItem.set isActive: @$isActive.is(':checked')



      render: ()->
        that = this
        tpl = _.template(FormMenuItemsTemplate, {item: @formItem})
        @$el.html(tpl)
        @bindingDom()
        @

    )
    return FormMenuItemsView

)