(function(window) {
    delete localStorage['ngStorage-registrationState'];
    delete localStorage['ngStorage-registrationError'];

    var registrationState,
        registrationHost,
        registrationAlias,
        registrationUsername,
        registrationPassword,
        registrationToken;

    try {
        registrationHost = JSON.parse(localStorage['ngStorage-registrationHost']);
        registrationAlias = JSON.parse(localStorage['ngStorage-registrationAlias']);
        registrationUsername = JSON.parse(localStorage['ngStorage-registrationUsername']);
        registrationPassword = loadRegPwd();
    } catch (e) {
        console.error('Failed to load registration details', e);
    }

    var registrationEventSource,
        registrationTokenRefreshInterval;

    var incomingCalls = {};

    var registrationReconnect = false,
        registrationReconnectTimeout = null,
        registrationReconnectInitialDelay = 1000,
        registrationReconnectMaxDelay = 120000,
        registrationReconnectDelay = registrationReconnectInitialDelay;

    function resetRegistrationReconnect() {
        registrationReconnect = false;
        window.clearTimeout(registrationReconnectTimeout);
        registrationReconnectTimeout = null;
        registrationReconnectDelay = registrationReconnectInitialDelay;
    }
    resetRegistrationReconnect();

    global.register = function(host, alias, username, password, callback, storePassword) {
        console.log("global.register", host, alias, username);
        registrationHost = host;
        registrationAlias = alias;
        registrationUsername = username;
        registrationPassword = password;
        saveRegPwd(storePassword ? password : '');
        global.unregister(function() {
            register();
        });
    };

    global.unregister = function(callback) {
        console.log("global.unregister");
        resetRegistrationReconnect();
        unregister(callback);
    };

    global.getReigstrationToken = function() {
        return registrationToken;
    };

    function onRegistered() {
        console.log("onRegistered");
        resetRegistrationReconnect();
        registrationReconnect = true;
        localStorage['ngStorage-registrationState'] = JSON.stringify('ACTIVE');
        global.setTrayIconGreen();
    }

    function onUnregistered() {
        console.log("onUnregistered");
        delete localStorage['ngStorage-registrationError'];
        registrationToken = null;
        localStorage['ngStorage-registrationState'] = JSON.stringify('UNREGISTERED');
        global.setTrayIconDefault();
    }

    function onRegistrationError(event) {
        console.error('onRegistrationError', event);
        unregister(function() {
            localStorage['ngStorage-registrationState'] = JSON.stringify('FAILED');
            global.setTrayIconRed();
            if (registrationReconnect) {
                console.log('registration reconnect atteppt in', registrationReconnectDelay/1000, 'seconds');
                registrationReconnectTimeout = window.setTimeout(function() {
                    register();
                }, registrationReconnectDelay);
                registrationReconnectDelay *= 2;
                registrationReconnectDelay = Math.min(registrationReconnectDelay, registrationReconnectMaxDelay);
            } else {
                localStorage['ngStorage-registrationError'] = JSON.stringify({
                    status: event.target.status
                });
            }
        });
    }

    function onIncomingCall(message) {
        console.log('registration.onIncomingCall', message);

        // message.host = host;
        var width = 350;
        var height = 56;
        var notificationWindow = require('nw.gui').Window.open('index.notification.html', {
            title: message.conference_alias,
            show: false,
            'show_in_taskbar': process.platform == "darwin",
            'visible-on-all-workspaces': true,
            toolbar: false,
            frame: false,
            resizable: false,
            width: width,
            height: height,
            min_width: width,
            min_height: height,
            max_width: width,
            max_height: height,
            focus: true,
            icon: 'configuration/favicon.png',
            'always-on-top': true
        });

        notificationWindow.once('loaded', function() {
            notificationWindow.window.postMessage({
                message: message,
                host: registrationHost
            }, '*');
            notificationWindow.moveTo(40, 40);
            notificationWindow.show();
            notificationWindow.setAlwaysOnTop(true);
            notificationWindow.focus();
        });

        notificationWindow.on('close', function() {
            delete incomingCalls[message.token];
            notificationWindow.close(true);
        });

        incomingCalls[message.token] = {
            notificationWindow: notificationWindow,
            message: message
        };
    }

    function onIncomingCallCancelled(message) {
        console.log('onIncomingCallCancelled', message);
        incomingCall = incomingCalls[message.token];
        if (incomingCall) {
            incomingCall.notificationWindow.close();
        }
    }

    global.callAccept = function(message) {
        console.log('global.callAccept', message);
        incomingCall = incomingCalls[message.token];
        if (incomingCall) {
            incomingCall.notificationWindow.close();
        }

        global.closeMainWindow();
        global.openConferenceWindow(
            registrationHost,
            message.conference_alias,
            undefined,
            message.token,
            'incoming');
    };

    global.callReject = function(message) {
        console.log('global.callReject', message);
        rejectCall(registrationHost, message.conference_alias, message.token);
        incomingCall = incomingCalls[message.token];
        if (incomingCall) {
            incomingCall.notificationWindow.close();
        }
    };

    global.callIgnore = function(message) {
        console.log('global.callIgnore', message);
        incomingCall = incomingCalls[message.token];
        if (incomingCall) {
            incomingCall.notificationWindow.close();
        }
    };

    function prepareRequest(method, url, callback) {
        var xhr = new XMLHttpRequest();
        xhr.timeout = 10 * 1000; // Set timeout to 10 seconds

        if (callback) {
            xhr.onload = function(e) {
                if (e.target.status == 200) {
                    callback(null, JSON.parse(e.target.responseText));
                } else {
                    callback(e);
                }
            };

            xhr.onerror = xhr.ontimeout = function(event) {
                callback(event);
            };
        }

        xhr.open(method, url);
        return xhr;
    }

    function requestToken(host, alias, username, password, callback) {
        var xhr = prepareRequest(
            'post', [
                "https:/", host, "api/client/v2/registrations", alias,
                "request_token"
            ].join('/'),
            callback);
        xhr.setRequestHeader("Authorization",
            "x-pexip-basic " + Base64.encode([username, password].join(':')));
        xhr.setRequestHeader('Content-type', 'application/json');
        xhr.send(JSON.stringify({}));
    }

    function refreshToken(host, alias, token, callback) {
        var xhr = prepareRequest(
            'post', [
                "https:/", host, "api/client/v2/registrations", alias,
                "refresh_token"
            ].join('/'),
            callback);
        xhr.setRequestHeader('Content-type', 'application/json');
        xhr.send(JSON.stringify({
            "token": token
        }));
    }

    function releaseToken(host, alias, token, callback) {
        var xhr = prepareRequest(
            'post',
            "https://" + host + "/api/client/v2/registrations/" + alias + "/release_token?token=" + token,
            callback);
        xhr.send();
    }

    function rejectCall(host, alias, token, callback) {
        var xhr = prepareRequest(
            'post',
            "https://" + host + "/api/client/v2/conferences/" + alias + "/release_token?token=" + token,
            callback);
        xhr.send();
    }

    function register() {
        console.log("register");
        if (registrationHost && registrationAlias) {
            delete localStorage['ngStorage-registrationError'];
            localStorage['ngStorage-registrationState'] = JSON.stringify('REGISTERING');
            var record = '_pexapp._tcp.' + registrationHost;
            require('dns').resolveSrv(record, function(error, addresses) {
                var vmrDetails;
                if (error) {
                    console.error('Unable to resolve', record, 'Falling back to', registrationHost);
                } else {
                    console.log('Resolved', record, addresses);
                    registrationHost = addresses[0].name;
                }

                requestToken(
                    registrationHost,
                    registrationAlias,
                    registrationUsername,
                    registrationPassword,
                    function(err, response) {
                        if (err) {
                            console.error('requestToken failed', response);
                            onRegistrationError(err);
                        } else {
                            registrationToken = response.result.token;
                            registrationEventSource = new EventSource("https://" + registrationHost + "/api/client/v2/registrations/" + registrationAlias + "/events?token=" + registrationToken);

                            registrationEventSource.addEventListener("incoming_cancelled", function(e) {
                                var msg = JSON.parse(e.data);
                                onIncomingCallCancelled(msg);
                            });

                            registrationEventSource.addEventListener("incoming", function(e) {
                                var msg = JSON.parse(e.data);
                                onIncomingCall(msg);
                            });

                            registrationEventSource.onopen = function(e) {
                                console.log('registrationEventSource.onopen', e);
                                registrationTokenRefreshInterval = window.setInterval(function() {
                                    refreshToken(registrationHost, registrationAlias, registrationToken, function(err, response) {
                                        if (err) {
                                            console.error('refreshToken failed', err);
                                            onRegistrationError(err);
                                        } else {
                                            // console.log('registration refreshToken succeeded', response)
                                            registrationToken = response.result.token;
                                        }
                                    });
                                }, (response.result.expires || 120) * 1000 / 3);

                                onRegistered();
                            };

                            registrationEventSource.onerror = onRegistrationError;
                        }
                    });
            });
        }
    }

    function unregister(callback) {
        console.log('unregister');
        localStorage['ngStorage-registrationState'] = JSON.stringify('UNREGISTERING');

        if (registrationEventSource) {
            registrationEventSource.close();
            registrationEventSource = null;
        }
        if (registrationTokenRefreshInterval) {
            window.clearInterval(registrationTokenRefreshInterval);
            registrationTokenRefreshInterval = null;
        }
        releaseToken(registrationHost, registrationAlias, registrationToken, function(err, result) {
            onUnregistered();
            if (callback) {
                callback();
            }
        });
    }

    register();
})(this);
