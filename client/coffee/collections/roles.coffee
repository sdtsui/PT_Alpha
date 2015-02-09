define([
  'jquery',
  'underscore'
  'Backbone'
  'models/role'
], ($, _, Backbone, RoleModel)->
  RolesCollection = Backbone.Collection.extend(
    model: RoleModel,
    initialize: (options)->
      console.log options
    url: '/api/roles/'
  )
  return RolesCollection
)
