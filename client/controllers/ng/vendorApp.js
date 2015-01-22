var vendorApp = angular.module('vendorApp', ['ngRoute', 'vendorAppControllers']);

var vendorAppControllers = angular.module('vendorAppControllers',[]);



vendorApp.config(['$routeProvider', function($routeProvider){

    $routeProvider.
        when('/vendor/venue',{
            templateUrl: 'views/templates/ng/vendor/venue/home.html',
            controller: 'venueController'
        }).
        when('/vendor/calendar',{
            templateUrl: 'views/templates/ng/vendor/calendar/home.html',
            controller: 'calendarController'
        }).
        when('/vendor/message',{
            templateUrl: 'views/templates/ng/vendor/message/home.html',
            controller: 'messageController'
        }).
        when('/vendor/prospects',{
            templateUrl: 'views/templates/ng/vendor/prospects/home.html',
            controller: 'prospectsController'
        }).
        otherwise({
            redirectTo: '/vendor/venue'
        });
}]);


