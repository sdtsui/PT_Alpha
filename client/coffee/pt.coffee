window.PrivateTable =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  Helpers: {}
  init: ()->
    window.venueRouter = new PrivateTable.Routers.VenueRouter()
    Backbone.history.start()

# require app.js
#= require_tree ./libs/
#= require_tree ./helpers/
#= require_tree ./models/
#= require_tree ./views/
#= require_tree ./routers