angular.module('nodeWheels.services',[]).factory('Item',function($resource){
    return $resource('/api/items/:id',{id:'@_id'},{
        update: {
            method: 'PUT'
        }
    });
}).service('popupService',function($window){
    this.showPopup=function(message){
        return $window.confirm(message);
    }
});