define([
  'underscore'
  'Backbone'
], (_, Backbone)->
  SignupModel = Backbone.Model.extend(
    defaults:
      venueName: ''
      venueUrl: ''
      name: ''
      jobTitle: ''
      email: ''
      password: ''

    initialize: (options)->

    validate: (attrs, options)->
      requiredAttrs = ['venueName', 'email', 'password', 'name']
      errors = {}
      _.each requiredAttrs, (attrName)->
        if !attrs[attrName]
          errors[attrName] ||= []
          errors[attrName].push 'can not be blank'

      if attrs.venueName && attrs.venueName.length <= 3
        errors['venueName'] ||= []
        errors['venueName'].push('is too short') 
        
      if attrs.venueUrl && !attrs.venueUrl.match(/(http(s?)\:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}((\S)*)$/i)
        errors['venueUrl'] ||= []
        errors['venueUrl'].push('is invalid')        

      if ! attrs.email.toString().match(/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/)
        errors['email'] ||= []
        errors['email'].push('is invalid')

      if attrs.password.toString().length < 6
        errors['password'] ||= []
        errors['password'].push('is so simple')

      if _.keys(errors).length > 0
        errors
      else
        false
  )

  return SignupModel

)
