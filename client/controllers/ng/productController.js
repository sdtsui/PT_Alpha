productAppControllers.controller('ProductController', ['$scope','$rootScope', function($scope, $rootScope){

    //assign active
    
    $scope.data = {
        
        'room':'Sophia Room',
        'venue':'The Clift Hotel'
                  
                  
    }
    
    $scope.$on('$viewContentLoaded', function(){
        console.log($scope.myform);
    });
    $rootScope.$on('subnav-click', function(e){
        //console.log(e);
        e.stopPropagation();
        console.log($(this).html);
    });
}]);

productAppControllers.controller('LayoutsController', function($scope){

        $scope.data = {'name':'layout'}
});