define([
  'jq'
  'underscore'
  'Backbone'
  'models/venue'
  'views/shared/alert_message'
  'text!templates/vendor/menu_items.html'
], ($
    _
    Backbone
    VenueModel
    AlertMessage
    MenuItemsTemplate
  )->
    MenuItemsView = Backbone.View.extend(
      el: '#setupContent'

      render: ()->
        that = this
        tpl = _.template(MenuItemsTemplate, {})
        @$el.html(tpl)
        @

    )
    return MenuItemsView

)