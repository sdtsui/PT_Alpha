// Load plugins
var gulp = require('gulp'),
    debug = require('debug')('app'),
    app = require('./app.js'),
    sass = require('gulp-ruby-sass'),
    jade = require('gulp-jade'),
    autoprefixer = require('gulp-autoprefixer'),
    minifycss = require('gulp-minify-css'),
    jshint = require('gulp-jshint'),
    uglify = require('gulp-uglify'),
    imagemin = require('gulp-imagemin'),
    rename = require('gulp-rename'),
    concat = require('gulp-concat'),
    notify = require('gulp-notify'),
    cache = require('gulp-cache'),
    nodemon = require('gulp-nodemon'),
    livereload = require('gulp-livereload'),
    runSequence = require('run-sequence'),
    rimraf = require('rimraf'),
    include        = require('gulp-include'),
    gutil = require('gulp-util'),
    coffee = require('gulp-coffee');



// These files include Foundation for Apps and its dependencies
var foundationJS = [
    'public/components/foundation/js/foundation.min.js',
    'public/components/foundation/js/foundation/foundation.abide.js',
    'public/components/foundation/js/vendor/modernizr.js',
    'public/components/parsleyjs/dist/parsley.min.js',
    'public/components/fastclick/lib/fastclick.js',
    'public/components/viewport-units-buggyfill/viewport-units-buggyfill.js',
    'public/components/tether/tether.js',
    'public/components/requirejs/require.js',
    'public/components/jquery/dist/jquery.js',
    'public/components/underscore/underscore.js',
    'public/components/backbone/backbone.js',
    'public/components/backbone-validation/dist/backbone-validation.js',
    'public/components/mustache/mustache.min.js',
    'public/components/side-comments/release/side-comments.js'
];

// these files are css from plugins
var pluginsCSS = [
    'public/components/side-comments/release/side-comments.css',
    'public/components/side-comments/release/themes/default-theme.css'
];
// Cleans the build directory
gulp.task('clean', function (cb) {
    rimraf('./public/assets', cb);
});

// Copies user-created files and Foundation assets
// TODO: should remove from gulp in future
gulp.task('copy', function () {
    var dirs = [
            './client/**/*.*',
            '!./client/assets/{scss,js,images,coffee}/**/*.*'
          ];

    // Everything in the client folder except templates, Sass, and JS
    gulp.src(dirs, {
        base: './client/'
        })
        .pipe(gulp.dest('./public/'))
        .pipe(livereload())
        .pipe(notify({
            message: 'Copy task complete'
        }));
});

// Styles
gulp.task('styles', function () {
    gulp.src(pluginsCSS)
        .pipe(gulp.dest('./public/assets/stylesheets'))
        .pipe(livereload())
        .pipe(notify({
            message: "Styles task complete <%= file.relative %>!"
        }));
    
    gulp.src('./client/assets/scss/app.scss')
        .pipe(sass({
            style: 'expanded',
        }))
        .on('error', function (e) {
            console.log(e);
        })
        .pipe(autoprefixer('last 2 version', 'safari 5', 'ie 8', 'ie 9', 'opera 12.1', 'ios 6', 'android 4'))
        .pipe(gulp.dest('./public/assets/stylesheets'))
        .pipe(rename({
            suffix: '.min'
        }))
        .pipe(minifycss())
        .pipe(gulp.dest('./public/assets/stylesheets'))
        .pipe(livereload())
        .pipe(notify({
            message: "Styles task complete <%= file.relative %>!"
        }));
});

gulp.task('coffees', function() {
  var dirs = [
          './client/coffee/**/*.coffee',
          // './client/coffee/**/*.*'
        ];
  // gulp.src('./client/coffee/**/*.coffee')
    gulp.src(dirs)
      .pipe( include() )
      // .pipe( coffee() )
      .pipe(coffee({bare: true}).on('error', gutil.log))
      // .pipe(uglify())
      // .pipe(concat('application.js'))
      // .pipe(uglify())
      .pipe(gulp.dest('./public/assets/js'))
      .pipe(livereload())
      .pipe(notify({
        message: "Coffee task complete <%= file.relative %>!"
      }));
      // .on('end', done)
});

// Scripts
gulp.task('scripts', function () {
    gulp.src(foundationJS)
        //.pipe(jshint('.jshintrc'))
        //.pipe(jshint.reporter('default'))
        //.pipe(concat('angular.js'))
        .pipe(gulp.dest('./public/assets/js'))
        .pipe(rename({
            suffix: '.min'
        }))
        .pipe(uglify())
        .pipe(gulp.dest('./public/assets/js'))
        .pipe(notify({
            message: 'Scripts for Backbonejs task complete'
        }));
    
    return gulp.src('./client/assets/js/**/*.js')
        .pipe(jshint('.jshintrc'))
        .pipe(jshint.reporter('default'))
        // .pipe(concat('app.js'))
        .pipe(gulp.dest('./public/assets/js'))
        .pipe(rename({
            suffix: '.min'
        }))
        .pipe(uglify())
        .pipe(gulp.dest('./public/assets/js'))
        .pipe(livereload())
        .pipe(notify({
            message: 'Scripts task complete'
        }));    
});

// Images
gulp.task('images', function () {
    return gulp.src('./client/assets/images/**/*')
        .pipe(cache(imagemin({
            optimizationLevel: 3,
            progressive: true,
            interlaced: true
        })))
        .pipe(gulp.dest('./public/assets/images'))
        .pipe(livereload())
        .pipe(notify({
            message: 'Images task complete'
        }));
});

gulp.task('templates', function() {
  return gulp.src('./client/templates/**/*.*')
    // .pipe(jade())
    .pipe(gulp.dest('./public/assets/js/templates/'))
    .pipe(livereload())
    .pipe(notify({
        message: "templates task complete <%= file.relative %>!"
    }));
});

// watch
gulp.task('watch',function () {
    livereload.listen();
    // Watch Sass
    gulp.watch(['./client/assets/scss/**/*.*'], ['styles']);

    // Watch JavaScript
    gulp.watch(['./client/assets/js/**/*.*'], ['scripts']);
    
    // Watch Images
    gulp.watch(['./client/assets/images/**/*.*'], ['images']);
    
    // Watch Images
    gulp.watch(['./client/templates/**/*.*'], ['templates']);
    
    // Watch coffee
    gulp.watch(['./client/coffee/**/*.*'], ['coffees']);
    
    // // Watch MVC + templates
    gulp.watch(['./client/**/*.*', '!./client/assets/{scss,images,coffee}/**/*.*'], ['copy']);

    // Watch any files in build/, reload on change

});


gulp.task('develop', function () {
  livereload.listen();
  nodemon({
    script: './bin/www',
    verbose: true,
    watch: './app/**',
    ignore: [
        './public/**',
        './client/**',
        './client/coffee/pt.coffee'
    ],
    // ext: 'js jade',
    ext: 'js coffee jade',
    nodeArgs: ['--debug=9999']
  }).on('restart', function () {
    console.log('restarting server..........');
    setTimeout(function () {
      livereload.changed();
    }, 500);
  });
});

gulp.task('build', function () {
    runSequence('clean', ['styles', 'coffees', 'scripts', 'images', 'templates'], 'copy',
        function () {
            console.log("Successfully built.");
        });
});


// launch gulp tasks
gulp.task('default', ['build', 'develop', 'watch'], function () {
    // startExpress();
    console.log('**************\nserver listening @ 3000\n**************');

});