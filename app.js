require('coffee-script/register');

var express = require('express'),
  config = require('./config/environment'),
  glob = require('glob'),
  mongoose = require('mongoose'),
  passport = require('passport');

mongoose.connect(config.db);
var db = mongoose.connection;
db.on('error', function () {
  throw new Error('unable to connect to database at ' + config.db);
});

var models = glob.sync(config.root + '/app/models/*.coffee');
models.forEach(function (model) {
  require(model);
});
var app = express();

require('./config/passport')(passport, config);
require('./config/express')(app, config, passport);

module.exports = app;
