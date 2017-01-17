angular.module('nodeWheels.controllers',[]).controller('ItemListController',function($scope,$state,popupService,$window,Item){

    $scope.items=Item.query();

    $scope.deleteItem=function(item){
        if(popupService.showPopup('Really delete this?')){
            item.$delete(function(){
                $window.location.href='';
            });
        }
    }

}).controller('ItemViewController',function($scope,$stateParams,Item){

    $scope.item=Item.get({id:$stateParams.id});

}).controller('ItemCreateController',function($scope,$state,$stateParams,Item){

    $scope.item=new Item();

    $scope.addItem=function(){
        $scope.item.$save(function(){
            $state.go('items');
        });
    }

}).controller('ItemEditController',function($scope,$state,$stateParams,Item){

    $scope.updateItem=function(){
        $scope.item.$update(function(){
            $state.go('items');
        });
    };

    $scope.loadItem=function(){
        $scope.item=Item.get({id:$stateParams.id});
    };

    $scope.loadItem();
});