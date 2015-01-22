// Load plugins
var gulp = require('gulp'),
    debug = require('debug')('app'),
    app = require('./app.js'),
    sass = require('gulp-ruby-sass'),
    autoprefixer = require('gulp-autoprefixer'),
    minifycss = require('gulp-minify-css'),
    jshint = require('gulp-jshint'),
    uglify = require('gulp-uglify'),
    imagemin = require('gulp-imagemin'),
    rename = require('gulp-rename'),
    concat = require('gulp-concat'),
    notify = require('gulp-notify'),
    cache = require('gulp-cache'),
    livereload = require('gulp-livereload'),
    runSequence = require('run-sequence'),
    rimraf = require('rimraf');

// start server 
function startExpress() {
    app.set('port', process.env.PORT || 3000);
    var server = app.listen(app.get('port'), function () {
        debug('Express server listening on port ' + server.address().port);
    });
}

// These files include Foundation for Apps and its dependencies
var foundationJS = [
    'public/components/foundation/js/foundation.min.js',
    'public/components/foundation/js/vendor/modernizr.js',
    'public/components/fastclick/lib/fastclick.js',
    'public/components/viewport-units-buggyfill/viewport-units-buggyfill.js',
    'public/components/tether/tether.js',
    'public/components/angular/angular.js',
    'public/components/angular-route/angular-route.js',
    'public/components/angular-animate/angular-animate.js',
    'public/components/angular-touch/angular-touch.js',
    'public/components/ui-router/release/angular-ui-router.js',
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
gulp.task('copy', function () {
    var dirs = [
            './client/**/*.*',
            '!./client/assets/{scss,js,images}/**/*.*'
          ];

    // Everything in the client folder except templates, Sass, and JS
    gulp.src(dirs, {
        base: './client/'
        })
        .pipe(gulp.dest('./public/assets'))
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
            message: 'Scripts for Angular task complete'
        }));
    
    return gulp.src('./client/assets/js/app.js')
        .pipe(jshint('.jshintrc'))
        .pipe(jshint.reporter('default'))
        .pipe(concat('app.js'))
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

// watch
gulp.task('watch',function () {
    livereload.listen();
    // Watch Sass
    gulp.watch(['./client/assets/scss/**/*'], ['styles']);

    // Watch JavaScript
    gulp.watch(['./client/assets/js/**/*'], ['scripts']);
    
    // Watch Images
    gulp.watch(['./client/assets/images/**/*'], ['images']);
    
    // Watch Images
    gulp.watch(['./client/views/**/*'], ['copy']);
    
    // Watch MVC + templates
    gulp.watch(['./client/**/*.*', '!./client/assets/{scss,js,images}/**/*.*'], ['copy']);

    // Watch any files in build/, reload on change

});

// Starts a test server, which you can view at http://localhost:8080
gulp.task('server:start', function () {
    startExpress();
});

gulp.task('build', function () {
    runSequence('clean', ['styles', 'scripts','images'], 'copy', 'watch',
        function () {
            console.log("Successfully built.");
        });
});


// launch gulp tasks
gulp.task('default', ['build'], function () {
    startExpress();
    console.log('**************\nserver listening @ 3000\n**************');

});