PrivateTable.setCurrentUser = (user)->
  PrivateTable.config.currentUser = user
PrivateTable.getCurrentUser = ()->
  PrivateTable.config.currentUser

# PrivateTable.buildErrorMessages = (errors)->
#   messages = []
#   if errors
#     if typeof(errors)=='string'
#       messages.push(errors)
#       return messages
#     else
#       if typeof(errors)=='object'
#         if errors instanceof Array
#           keys = Object.keys(messages)
          

require.config(
  baseUrl: '/assets/js/'
  paths:
    jquery: 'jquery.min'
    foundation: 'foundation.min'
    parsleyjs: 'parsley.min'
    underscore: 'underscore.min'
    Backbone: 'backbone.min'
    Dropzone: 'dropzone.min'
    # 'backbone.validation': 'backbone-validation.min'
    text: 'require-text.min'
    Templates: './templates'
  shim:
    foundation: 
      deps: ['jquery']
    'foundation.abide': 
      deps: ['foundation', 'jquery']
    parsleyjs:
      deps: ['jquery']

  wrapShim: true

  # shim:
  #   backbone: 
  #     deps: ['underscore', 'jquery']
  #     exports: 'Backbone'
  #   'backbone.validation': 
  #     deps: ['backbone']
  #     exports: 'Backbone.Validation'
)


require([
  'pt_app'
], (PtApp)->
  PtApp.init()
)

