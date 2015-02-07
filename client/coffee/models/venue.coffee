define([
  'underscore'
  'Backbone'
], (_, Backbone)->
  VenueModel = Backbone.Model.extend(
    idAttribute: "_id"
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
      businessHour:
        openTime: 5
        closeTime: 23
      timeZone: ''
      cuisineType: ''
      currency: ''

    initialize: (options)->
      console.log 'new VenueModel'

    validate: (attrs, options)->
      requiredAttrs = ['name']
      errors = {}
      _.each requiredAttrs, (attrName)->
        if !attrs[attrName]
          errors[attrName] ||= []
          errors[attrName].push 'can not be blank'

        
      if attrs.url && !attrs.url.match(/(http(s?)\:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}((\S)*)$/i)
        errors['url'] ||= []
        errors['url'].push('is invalid')        

      if attrs.email && !attrs.email.toString().match(/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/)
        errors['email'] ||= []
        errors['email'].push('is invalid')

      if _.keys(errors).length > 0
        errors
      else
        false

  )

  return VenueModel

)
