define([
  'jquery'
  'underscore'
  'Backbone'
  'dropzone'
  'views/shared/alert_message'
  'text!templates/shared/fileupload.html'
], ($
    _
    Backbone
    dropzone
    AlertMessage
    FileUploadTemplate
  )->

    FileUploadView = Backbone.View.extend(

      tagName: 'div'
      events:
        'change .searchQuery': 'searchQuery'
        'click i.addItem': 'addItem'
        'click .addNewTag': 'addNewTag'

      
      initialize: (options)->
        console.log options
        console.log 'dropzone'
        console.log dropzone
        console.log window.Dropzone

      render: ()->
        that = this
        tpl = _.template(FileUploadTemplate, {_: _})
        @$el.html(tpl)
        # fileForm = new window.Dropzone('#myaaa', {url: '/aaaaa'})
        @
    )
    return FileUploadView
)