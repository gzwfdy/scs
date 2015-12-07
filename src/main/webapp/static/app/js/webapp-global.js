'use strict';

angular.module('pexapp')

.factory('globalService', function(toggleService, defaultUserSettings, $timeout, $localStorage, $log) {
    $localStorage.registrationState = 'INACTIVE';
    if (window.srv) {
        window.srv.addRegisteredCallback(function(isRegistered) {
            $log.debug("Registered", isRegistered);
                $timeout(function() {
                    $localStorage.registrationState = 'ACTIVE';
                    // $localStorage.registered = isRegistered;
                });
            });
        $timeout(function() {
            // $localStorage.registered = window.srv.service("registration_status").content == 'ACTIVE';
            $localStorage.registrationState = window.srv.service("registration_status").content;
        });
    }
    return {
        VERSION_STRING: "<REPLACE_ME>",
        register: function(host, alias, username, password, apply, remember) {
            saveRegPwd(remember ? password : '');
            // Resolve srv then register
            function doRegister(newHost) {
                window.srv.service(
                    'register',
                    JSON.stringify({"hostname": newHost, "alias": alias,
                                    "username": username, "password": password}));
            }
            var promise = window.srv.resolveSrvAsync(host);
            promise.then(
                function(result) {
                    var newhost = result.content.replace(/https:\/\//, '');
                    doRegister(newhost);
                },
                function(error) {
                    doRegister(host);
                }
            );
        },
        unregister: function() {
            $timeout(function() {
                $localStorage.registrationState = 'UNREGISTERING';
            });
            window.srv.service("stop");
            window.srv.service("start");
        },
        openSettings: function() {
            toggleService.toggle('dialog-settings');
        },
        settingsSubmit: function(value) {
            // scope.$emit('toggle::' + attrs.id, value);
            toggleService.toggle('dialog-settings', value);
        },
        onDisconnect: function() {

        },
    };
});
