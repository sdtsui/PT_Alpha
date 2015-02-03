define([
  'jquery'
  'underscore'
  'Backbone'
  'text!templates/signup.html'
], ($, _, Backbone, SignupTemplate)->

	SignupView = Backbone.View.extend(
		initialize: (options)->
			console.log $
			console.log _
			console.log 'init SignupView'

		render: ->
			tpl = _.template(SignupTemplate, {})
			console.log tpl
			@$el.html(tpl)
	)

	return SignupView

)
