// venue controller
vendorAppControllers.controller('VenueController', ['$scope','$rootScope', function($scope, $rootScope){

    //assign active
    
    $scope.data = {
        
        'room':'Sophia Room',
        'venue':'The Clift Hotel',
        'menuitems':[
            {
                'id':'001',
                'name':'Clear Heirloom Tomato Gazpacho',
                'class':'A',
                'price':'',
                'category':'',
                'subcategory':'',
                'course': ''
            },
            {
                'id':'002',
                'name':'Seared Watermelon',
                'class':'A',
                'price':'',
                'category':'',
                'subcategory':'',
                'course': ''
            },
            {
                'id':'003',
                'name':'Californian Halibut Sashimi',
                'class':'A',
                'price':'',
                'category':'banquet',
                'subcategory':'plated',
                'course': 'appetizer'
            },
            {
                'id':'004',
                'name':'Organic Free Range Chicken',
                'class':'B',
                'price':'',
                'category':'',
                'subcategory':'',
                'course': 'appetizer'
            },
            {
                'id':'005',
                'name':'Grilled King Trumpet Mushrooms',
                'class':'B',
                'price':'',
                'category':'',
                'subcategory':'',
                'course': 'appetizer'
            },
            {
                'id':'006',
                'name':'Pan Roasted Filet of Arctic Char',
                'class':'B',
                'price':'',
                'category':'',
                'subcategory':'',
                'course': 'entree'
            },
            {
                'id':'007',
                'name':'Pan Roasted Filet of Arctic Char',
                'class':'B',
                'price':'',
                'category':'',
                'subcategory':'',
                'course': 'entree'
            },
            {
                'id':'008',
                'name':'Roast Loin of Californian Lamb',
                'class':'C',
                'price':'',
                'category':'',
                'subcategory':'',
                'course': 'entree'
            },
            {
                'id':'009',
                'name':'Wagyu Strip Steak ',
                'class':'C',
                'price':'',
                'category':'',
                'subcategory':'',
                'course': 'entree'
            },
            {
                'id':'010',
                'name':'Stinging Nettle Gnocchi',
                'class':'C',
                'price':'',
                'category':'',
                'subcategory':'',
                'course': 'entree'
            },
            {
                'id':'011',
                'name':'Pork and Shrimp Dumpings',
                'class':'C',
                'price':'',
                'category':'',
                'subcategory':'',
                'course': 'entree'
            },
            {
                'id':'012',
                'name':'Peking Duck',
                'class':'C',
                'price':'',
                'category':'',
                'subcategory':'',
                'course': 'entree'
            },
            {
                'id':'013',
                'name':'Slow Roasted Pork',
                'class':'C',
                'price':'',
                'category':'',
                'subcategory':'',
                'course': 'entree'
            },
            {
                'id':'014',
                'name':'Summer Fruit Gratin ',
                'class':'D',
                'price':'',
                'category':'reception',
                'subcategory':'tray passed',
                'course': 'dessert'
            },
            {
                'id':'015',
                'name':'Chocolate Semifreddo Terrine',
                'class':'D',
                'price':'',
                'category':'banquet',
                'subcategory':'plated',
                'course': 'dessert'
            },
            {
                'id':'016',
                'name':'Raspberry Shortcake',
                'class':'A',
                'price':'',
                'category':'banquet',
                'subcategory':'family style',
                'course': 'dessert'
            }
        ]
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

// calendar controller
vendorAppControllers.controller('calendarController', function($scope){

        $scope.data = {'name':'layout'}
});

// message controller
vendorAppControllers.controller('messageController', function($scope){

        $scope.data = {'name':'layout'}
});

// prospects controller
vendorAppControllers.controller('prospectsController', function($scope){

        $scope.data = {'name':'layout'}
});