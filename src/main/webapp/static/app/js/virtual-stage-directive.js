'use strict';

angular.module('pexapp')

.directive('virtualStage', function($log) {
    return {
        templateUrl: 'templates/virtual-stage.html',
        scope: {
            connection: '=',
        }
    };
});
