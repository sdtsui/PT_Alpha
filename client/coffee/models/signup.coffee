define([
  'underscore'
  'Backbone'
], (_, Backbone)->
  SignupModel = Backbone.Model.extend(
    defaults:
      venueName: ''
      venueUrl: ''
      fullName: ''
      jobTitle: ''
      email: ''
      password: ''

    initialize: (options)->

    validate: (attrs, options)->
      requiredAttrs = ['venueName', 'email', 'password', 'fullName']

      errors = {}
      _.each requiredAttrs, (attrName)->
        if !attrs[attrName]
          errors[attrName] ||= []
          errors[attrName].push 'can not be blank'

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


    paramRoot: 'user'
  )

  return SignupModel

)
