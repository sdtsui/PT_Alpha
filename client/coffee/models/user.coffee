# coffee/models/user

class PrivateTable.Models.User extends Backbone.Model
  paramRoot: 'user'


class PrivateTable.Models.UsersCollection extends Backbone.Collection
  model: PrivateTable.Models.User
  url: '/api/users'

