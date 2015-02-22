define([
  'jq'
  'underscore'
  'Backbone'
  'views/shared/alert_message'
  'text!templates/vendor/rooms/form_layout.html'
], ($
    _
    Backbone
    AlertMessage
    FormLayoutTemplate
  )->
    FormLayoutView = Backbone.View.extend(
      tagName: 'div'
      className: 'row'


      initialize: (options)->
        @formLayout = options.formLayout
        @layouts = options.layouts

      bindingDom: ()->
        @$name = @$('input[name="name"]')
        @$name.on 'blur', => 
          @formLayout.set name: @$name.val()

        @$roomType = @$('select[name="roomType"]')
        @$roomType.on 'change', => 
          @formLayout.set roomType: @$roomType.val()

        @$roomSizeValue = @$('input[name="roomSizeValue"]')
        @$roomSizeValue.on 'change', => 
          roomSize = @formLayout.get('roomSize') || {}
          roomSize.value = @$roomSizeValue.val()
          @formLayout.set roomSize: roomSize        

      render: ()->
        that = this
        tpl = _.template(FormLayoutTemplate, {_: _, layout: @formLayout.toJSON()})
        @$el.html(tpl)
        @

    )
    return FormLayoutView

)