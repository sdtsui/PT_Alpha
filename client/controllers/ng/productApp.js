var productApp = angular.module('productApp',['ngRoute', 'productAppControllers']);

var productAppControllers = angular.module('productAppControllers',[]);

productApp.config(['$routeProvider', function($routeProvider){
    
    $routeProvider.
        when('/room',{
            templateUrl: 'views/templates/ng/pdp/room.html',
            controller: 'ProductController'
        }).
        when('/layouts',{
            templateUrl: 'views/templates/ng/pdp/layouts.html',
            controller: 'ProductController'
        }).
        when('/services',{
            templateUrl: 'views/templates/ng/pdp/services.html',
            controller: 'ProductController'
        }).
        when('/menus',{
            templateUrl: 'views/templates/ng/pdp/menus.html',
            controller: 'ProductController'
        }).
      otherwise({
        redirectTo: '/room'
      });
}]);
