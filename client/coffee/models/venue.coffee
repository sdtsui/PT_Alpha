# coffee/models/venue
class PrivateTable.Models.Venue extends Backbone.Model
  paramRoot: 'venue'


class PrivateTable.Models.VenuesCollection extends Backbone.Collection
  model: PrivateTable.Models.Venue
  url: '/api/venues'

