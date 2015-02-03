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
      if ! attrs.venueName || !attrs.venueName.length < 1
        return 'Venue can not be blank'
      
    paramRoot: 'user'
  )

  return SignupModel

)
