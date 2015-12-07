'use strict';

angular.module('pexapp')

.factory('callHistory', function($localStorage, defaultUserSettings) {
    var values = [];

    function load() {
        angular.copy([], values);
        angular.forEach($localStorage.callHistory, function(value, key) {
            values.push({
                alias: key,
                avatarUrl: value.avatarUrl,
                timestamp: value.timestamp,
                status: value.status
            });
        });
    }
    load();

    return {
        values: values,
        add: function(alias, avatarUrl, status) {
            if (!alias) {
                return;
            }
            $localStorage.callHistory[alias] = {
                avatarUrl: avatarUrl,
                timestamp: Date.now(),
                status: status
            };
            load();
        },
        remove: function(alias) {
            delete $localStorage.callHistory[alias];
            load();
        },
        clear: function() {
            $localStorage.callHistory = {};
            load();
        },
    };
});
