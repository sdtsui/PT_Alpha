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


        

      render: ()->
        that = this
        tpl = _.template(FormMenuItemsTemplate, {})
        @$el.html(tpl)
        @

    )
    return FormMenuItemsView

)