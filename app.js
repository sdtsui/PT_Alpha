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

var controllers = glob.sync(config.root + '/app/controllers/**/*.coffee');

controllers.forEach(function(controller) {
  return require(controller)(app, passport);
});

app.use(function(req, res, next) {
  var err;
  err = new Error('Not Found');
  err.status = 404;
  return next(err);
});

if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    return res.render('error', {
      message: err.message,
      error: err,
      title: 'error'
    });
  });
}

app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  return res.render('error', {
    message: err.message,
    error: {},
    title: 'error'
  });
});
module.exports = app;
