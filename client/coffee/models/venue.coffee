define([
  'underscore'
  'Backbone'
], (_, Backbone)->
	VenueModel = Backbone.Model.extend(
		defaults:
			name: ''

		initialize: (options)->
			console.log 'new VenueModel'

		paramRoot: 'venue'
	)

	return VenueModel

)
