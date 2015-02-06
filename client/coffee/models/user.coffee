define([
  'underscore'
  'Backbone'
], (_, Backbone)->
  UserModel = Backbone.Model.extend(
    idAttribute: "_id"
    defaults:
      name: ''

    initialize: (options)->
      console.log 'new UserModel'

    paramRoot: 'user'
  )

  return UserModel

)
