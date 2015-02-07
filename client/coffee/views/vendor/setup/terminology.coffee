define([
  'jquery'
  'underscore'
  'Backbone'
  'models/venue'
  'views/shared/alert_message'
  'text!templates/vendor/setup/terminology.html'
], ($, _, Backbone, VenueModel, AlertMessage, TerminologyTemplate)->

  TerminologySetupView = Backbone.View.extend(
    tagName: 'div'
    # className: 'sticky'
    events:
      'click .cancelVenue': 'cancelVenue'
      'click .updateVenue': 'updateVenue'
      # 'click .deleteVenue': 'deleteVenue'

    cancelVenue: (e)->
      e.preventDefault()
      e.stopPropagation()
      @venue = @model.clone()
      @buildHtml()

    updateVenue: (e)->
      e.preventDefault()
      e.stopPropagation()
      console.log @venue.isValid()
      console.log @venue.isNew()
      if @venue.isValid()
        @venue.save()
        @model = @venue.clone()
        msg = new AlertMessage({type: 'success', messages: ["Venue was updated successfully."]})
        @$el.prepend(msg.render().el)
      else
        console.log @venue
        msg = new AlertMessage({messages: ["There are some errors"]})
        @$el.prepend(msg.render().el)

    deleteVenue: (e)->
      e.preventDefault()
      e.stopPropagation()
      console.log @venue.toJSON()
      console.log @venue.isNew()


    initialize: (options={})->
      that = this
      that.options = options || {}
      that.venue = new VenueModel()
      that.model = that.venue
      that.venue.url = '/api/venues/mine'
      @initConstant()

    initConstant: ->
      @BUSINESS_HOURS = 
        OPEN: 
          5: '5:00a'
          6: '6:00a'
          7: '7:00a'
          8: '8:00a'
          9: '9:00a'
          10: '10:00a'
        CLOSE:
          19: '7:00p'
          20: '8:00p'
          21: '9:00p'
          22: '10:00p'
          23: '11:00p'

      @TIME_ZONES =
        pacific: "Pacific Standard Time"
        easter: "Eastern Standard Time"
        central: "Central Standard Time"

      @CURRENCY =
        USD: "US Dollars"
        EUR: "Euro"

      @CUISINE_TYPES =
        american: "American"
        japanese: "Japanese"
        korean: "Korean"

    bindingDom: ->
      @$name = @$('input[name="name"]')
      @$name.on 'blur', => 
        @venue.set name: @$name.val()

      @$address = @$('input[name="address"]')
      @$address.on 'blur', => 
        @venue.set address: @$address.val()

      @$phone = @$('input[name="phone"]')
      @$phone.on 'blur', => 
        @venue.set phone: @$phone.val()

      @$fax = @$('input[name="fax"]')
      @$fax.on 'blur', => 
        @venue.set fax: @$fax.val()

      @$url = @$('input[name="url"]')
      @$url.on 'blur', => 
        @venue.set url: @$url.val()

      @$email = @$('input[name="email"]')
      @$email.on 'blur', => 
        @venue.set email: @$email.val()

      @$taxInMenu = @$('input[name="taxInMenu"]')
      @$taxInMenu.on 'click', => 
        @venue.set taxInMenu: @$taxInMenu.is(':checked')

      @$tax = @$('input[name="tax"]')
      @$tax.on 'blur', => 
        @venue.set tax: @$tax.val()

      @$gratuity = @$('input[name="gratuity"]')
      @$gratuity.on 'blur', => 
        @venue.set gratuity: @$gratuity.val()

      @$businessHourOpen = @$('select[name="businessHourOpen"]')
      @$businessHourOpen.on 'change', =>
        businessHour = @venue.get('businessHour') || {}
        businessHour.openTime = @$businessHourOpen.val()
        @venue.set 'businessHour': businessHour

      @$businessHourClose = @$('select[name="businessHourClose"]')
      @$businessHourClose.on 'change', => 
        businessHour = @venue.get('businessHour') || {}
        businessHour.closeTime = @$businessHourClose.val()
        @venue.set 'businessHour': businessHour

      @$timeZone = @$('input[name="timeZone"]')
      @$timeZone.on 'blur', => 
        @venue.set timeZone: @$timeZone.val()

      @$cuisineType = @$('input[name="cuisineType"]')
      @$cuisineType.on 'blur', => 
        @venue.set cuisineType: @$cuisineType.val()

      @$currency = @$('input[name="currency"]')
      @$currency.on 'blur', => 
        @venue.set currency: @$currency.val()

    buildHtml: ()->
      that = this


    render: ()->
      that = this
      tpl = _.template(TerminologyTemplate, {})
      @$el.html tpl
      @

  )
  return TerminologySetupView

)