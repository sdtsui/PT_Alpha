require.config(
  baseUrl: '/assets/js/'
  paths:
    jquery: 'jquery.min'
    underscore: 'underscore.min'
    Backbone: 'backbone.min'
    text: 'require-text.min'
    Templates: './templates'
)


require([
  'pt_app'
], (PtApp)->
  PtApp.init()
)

