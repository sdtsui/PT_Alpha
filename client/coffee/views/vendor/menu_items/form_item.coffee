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
        'click .deleteMenuItem': 'deleteMenuItem'
        'click .cancelMenuItem': 'cancelMenuItem'
        'click .saveMenuItem': 'saveMenuItem'

      deleteMenuItem: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @$el.remove()

      cancelMenuItem: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        @$el.remove()

      saveMenuItem: (e)->
        e.preventDefault()
        e.stopPropagation()
        $e = $(e.currentTarget)
        console.log @formItem.toJSON()

      initialize: (options)->
        @formItem = options.formItem
        @items = options.items

      bindingDom: ()->
        @$name = @$('input[name="name"]')
        @$name.on 'blur', => 
          @formItem.set name: @$name.val()

        @$description = @$('textarea[name="description"]')
        @$description.on 'blur', => 
          @formItem.set description: @$description.val()

        @$subcategory = @$('select[name="subcategory"]')
        @$subcategory.on 'blur', => 
          @formItem.set subcategory: @$subcategory.val()       

        @$isActive = @$('input[name="isActive"]')
        @$isActive.on 'click', => 
          @formItem.set isActive: @$isActive.is(':checked')

        @$priceValue = @$('input[name="priceValue"]')
        @$priceValue.on 'blur', => 
          price = @formItem.get('price') || {}
          price.value = @$priceValue.val()
          @formItem.set price: price

        @$priceUnit = @$('select[name="priceUnit"]')
        @$priceUnit.on 'change', => 
          price = @formItem.get('price') || {}
          price.unit = @$priceUnit.val()
          @formItem.set price: price

        @$guestCountRequired = @$('input[name="guestCountRequired"]')
        @$guestCountRequired.on 'click', => 
          guest = @formItem.get('guest') || {}
          guest.countRequired = @$guestCountRequired.is(':checked')
          @formItem.set guest: guest

        @$guestCountValue = @$('input[name="guestCountValue"]')
        @$guestCountValue.on 'blur', => 
          guest = @formItem.get('guest') || {}
          guest.countValue = @$guestCountValue.val()
          @formItem.set guest: guest



      render: ()->
        that = this
        tpl = _.template(FormMenuItemsTemplate, {item: @formItem})
        @$el.html(tpl)
        @bindingDom()
        @

    )
    return FormMenuItemsView

)