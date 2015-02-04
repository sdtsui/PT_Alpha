require.config(
  baseUrl: '/assets/js/'
  paths:
    jquery: 'jquery.min'
    underscore: 'underscore.min'
    Backbone: 'backbone.min'
    # 'backbone.validation': 'backbone-validation.min'
    text: 'require-text.min'
    Templates: './templates'
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

