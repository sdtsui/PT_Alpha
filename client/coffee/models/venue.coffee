define([
  'underscore'
  'Backbone'
], (_, Backbone)->
  VenueModel = Backbone.Model.extend(
    defaults:
      name: ''
      address: ''
      phone: ''
      fax: ''
      url: ''
      email: ''
      taxInMenu: ''
      tax: ''
      gratuity: ''
      businessHour: ''
      timeZone: ''
      cuisineType: ''
      currency: ''

    initialize: (options)->
      console.log 'new VenueModel'

    validate: (attrs, options)->
      requiredAttrs = ['name']
      
      false
    # paramRoot: 'venue'
  )

  return VenueModel

)
