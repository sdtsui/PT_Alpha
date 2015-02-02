PrivateTable.Views.Auths ||= {}

class PrivateTable.Views.Auths.SignupView extends Backbone.View
  template: '/assets/templates/signup.html'

  render: ->
    console.log @template()
    $(@el).html @template()