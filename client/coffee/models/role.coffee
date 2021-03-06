define([
  'underscore'
  'Backbone'
], (_, Backbone)->
  RoleModel = Backbone.Model.extend(
    idAttribute: "_id"
    defaults:
      name: ''
      role: 'EVENT_MANAGER'
      email: ''
      phone: ''
      isActive: true
      
      notifications:
        newProspect:
          email: true
          phone: true
        newMessage:
          email: true
          phone: true
        newEvent:
          email: true
          phone: true
        abandonCart:
          email: true
          phone: true
    
    url: '/api/roles'

    initialize: (options)->
      console.log 'new RoleModel'

  )

  return RoleModel

)
