define([
  'underscore'
  'Backbone'
], (_, Backbone)->
  UserModel = Backbone.Model.extend(
    defaults:
      name: ''

    initialize: (options)->
      console.log 'new UserModel'

    paramRoot: 'user'
  )

  return UserModel

)
