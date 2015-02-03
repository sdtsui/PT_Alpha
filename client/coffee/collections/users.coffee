define([
  'jquery',
  'underscore'
  'Backbone'
  'models/user'
], ($, _, Backbone, UserModel)->
  UsersCollection = Backbone.Collection.extend(
    model: UserModel,
    initialize: (options)->
      console.log options
    url: '/api/users/'
  )
  return UsersCollection
)
