'use strict';
/* global angular, require, PexRegistration */

if (window.location.search) {
    if (!window.location.origin) {
        window.location.origin =
            window.location.protocol + '//' +
            window.location.hostname +
            (window.location.port ? ':' + window.location.port : '');
    }
    window.location.href =
        window.location.origin +
        window.location.pathname +
        '#/' + window.location.search;
}

angular.module('pexapp')

.controller('MainController', function(
    $scope,
    $log,
    $sce,
    $q,
    $localStorage,
    $window,
    $timeout,
    $location,
    $translate,
    platformSettings,
    applicationSettings,
    defaultUserSettings,
    serverSettings,
    toast,
    modal,
    Call,
    toggleService,
    flashVideo) {

    $scope.flashVideo = flashVideo;
    $scope.toggle = toggleService.toggle;
    $scope.toastMessages = toast.messages;
    $scope.getModalMessage = modal.getMessage;
    $scope.errorMessage = null;
    $scope.plugins = applicationSettings.plugins;
    $scope.params.conference = '560000';
    $scope.params.pin = '356789';
    $scope.update = function() {
        $scope.$apply(function() {});
    };

    $scope.pexrtcSrc = $sce.trustAsResourceUrl('https://' + applicationSettings.serverAddress + "/static/webrtc/js/pexrtc.js");

    function getVmrDetails(uri) {
        var deferred = $q.defer();
        if (!applicationSettings.serverAddress && $localStorage.serverAddress) {
            deferred.resolve({
                host: $localStorage.serverAddress,
                alias: uri
            });
        } else if (applicationSettings.serverAddress) {
            deferred.resolve({
                host: applicationSettings.serverAddress,
                alias: uri
            });
        } else if (platformSettings.isDesktopClient) {
            var fullUri = uri.search('@') < 0 ? uri + '@' + $localStorage.defaultDomain : uri;
            var uriComponents = fullUri.split('@');
            var domain = uriComponents[1];
            var record = '_pexapp._tcp.' + domain;
            var dns = require('dns');
            dns.resolveSrv(record, function(error, addresses) {
                var vmrDetails;
                if (error) {
                    $log.debug('Unable to resolve', record, 'Falling back to', domain);
                    vmrDetails = {
                        host: domain,
                        alias: uriComponents[0]
                    };
                } else {
                    $log.debug('Resolved', record, addresses);
                    vmrDetails = {
                        host: addresses[0].name,
                        alias: fullUri
                    };
                }
                deferred.resolve(vmrDetails);
            });
        } else if (window.srv) {
            var fullUri = uri.search('@') < 0 ? uri + '@' + $localStorage.defaultDomain : uri;
            var uriComponents = fullUri.split('@');
            var domain = uriComponents[1];
            var promise = window.srv.resolveSrvAsync(domain);
            promise.then(
                function(result) {
                    var vmrDetails = {
                        host: result.content.replace(/https:\/\//, ''),
                        alias: fullUri
                    };
                    $timeout(function() {
                        deferred.resolve(vmrDetails);
                    });
                },
                function(error) {
                    var vmrDetails = {
                        host: domain,
                        alias: fullUri
                    };
                    $timeout(function() {
                        deferred.resolve(vmrDetails);
                    });
                }
            );
        }

        return deferred.promise;
    }

    $scope.loginApp = function(alias, displayName) {
        if ($scope.globalService.join) {
            $scope.globalService.join(alias, displayName);
        } else {
            $scope.login(alias, displayName);
        }
    };

    $scope.setErrorMessage = function(message) {
        $scope.errorMessage = message;
        if (platformSettings.isAndroidClient) {
            $translate(message).then(function(result) {
                window.srv.service("toast", result);
            });
        }
    };

    $scope.login = function(alias, displayName, pin, token, extension) {
        $log.debug('$scope.login', alias, displayName, pin, token);

        $localStorage.conference = alias;
        $localStorage.name = displayName;
        $scope.errorMessage = '';

        if (!displayName) {
            $scope.setErrorMessage('IDS_SETTINGS_DISPLAY_NAME_PLACEHOLDER');
            return;
        }

        $scope.loadingConference = true;
        $scope.sendKeenEvent('callPlaced', null, serverSettings.analyticsReportingEnabled);

        if ($scope.call) {
            $log.debug('$scope.login: setting pin');
            $scope.call.connect(pin, extension);
            return;
        } else if (!$scope.connection) {
            $scope.connection = {
                participants: {},
                stage: [],
                participantAdd: function(uri, protocol, role, presentationUri) {
                    $scope.sendKeenEvent(
                        'dialParticipant', {
                            protocol: protocol,
                            role: role,
                            uuid: $scope.connection.data.uuid,
                            usedPresentation: presentationUri ? true : false
                        },
                        $scope.connection.data.analyticsEnabled);
                    $scope.call.participantAdd(uri, protocol, role, presentationUri);
                },
                participantAddDone: function() {
                    $timeout(function() {
                        delete $scope.connection.dialOutState;
                    }, 2500);
                },
                participantAddCancel: function() {
                    angular.forEach($scope.connection.dialOutState.result, function(uuid) {
                        $scope.call.participantDisconnect({
                            uuid: uuid
                        });
                    });
                    delete $scope.connection.dialOutState;
                },
                participantAddIgnore: function() {
                    delete $scope.connection.dialOutState;
                },
                participantToggleMute: function(participant) {
                    $scope.call.participantToggleMute(participant);
                },
                participantUnlock: function(participant) {
                    $scope.call.participantUnlock(participant);
                },
                participantDisconnect: function(participant) {
                    $translate([
                        'IDS_PARTICIPANT_DISCONNECT',
                        'IDS_PARTICIPANT_DISCONNECT_MESSAGE'
                    ], {
                        displayName: participant.displayName
                    }).then(function(translations) {
                        modal.confirm(
                            translations.IDS_PARTICIPANT_DISCONNECT,
                            translations.IDS_PARTICIPANT_DISCONNECT_MESSAGE,
                            function() {
                                $scope.call.participantDisconnect(participant);
                            },
                            null,
                            'IDS_BUTTON_DISCONNECT');
                    });
                },
                disconnectAll: function() {
                    modal.confirm(
                        'IDS_CONFERENCE_DISCONNECT_ALL',
                        'IDS_CONFERENCE_DISCONNECT_ALL_MESSAGE',
                        function() {
                            $scope.call.disconnectAll();
                        },
                        null,
                        'IDS_BUTTON_DISCONNECT');
                },
                toggleCamera: function() {
                    $scope.connection.cameraEnabled = !$scope.call.toggleCamera();
                }
            };

            var registration_token = null;
            if (platformSettings.isDesktopClient)
            {
                registration_token = global.getReigstrationToken();
            }

            if ($scope.params.host) {
                $scope.callHistory.add(
                    alias,
                    $scope.getConferenceAvatarUrl(alias, $scope.params.host),
                    $scope.params.direction || 'outgoing');
                $scope.call = new Call(
                    $scope.params.host,
                    alias,
                    displayName,
                    token,
                    registration_token);
            } else {
                getVmrDetails(alias).then(function(vmrDetails) {
                    $scope.callHistory.add(
                        alias,
                        $scope.getConferenceAvatarUrl(vmrDetails.alias, vmrDetails.host),
                        $scope.params.direction || 'outgoing');
                    $scope.call = new Call(
                        vmrDetails.host,
                        vmrDetails.alias,
                        displayName,
                        token,
                        registration_token);
                });
            }
        }
    };

    $scope.disconnect = function(navigate) {
        $log.debug('$scope.disconnect', navigate);
        if ($scope.call) {
            $scope.call.disconnect();
        }
        if ($scope.errorMessage !== 'Call Failed: Invalid PIN') {
            delete $scope.pinRequested;
            delete $scope.extensionRequested;
        }
        if (navigate) {
            if (platformSettings.isDesktopClient && !$scope.errorMessage) {
                window.close();
            } else {
                var href = window.location.href.substring(0,window.location.href.indexOf("static"));
                window.location.href = href+"z";//window.location.href.split('#')[0];
            }
        } else {
            delete $scope.loadingConference;
            delete $scope.params.pin;
            delete $scope.params.extension;
            delete $scope.call;
            delete $scope.connection;
        }
    };

    $scope.cancelLogin = function() {
        delete $scope.errorMessage;
        $scope.disconnect(platformSettings.isDesktopClient);
    };

    var _oldOnBeforeUnload = window.onbeforeunload;
    window.onbeforeunload = function() {
        $log.debug('MainController onbeforeunload');
        if (angular.isFunction(_oldOnBeforeUnload)) {
            _oldOnBeforeUnload();
        }
        $scope.disconnect();
    };

    $scope.$on('$destroy', function() {
        $log.debug('$destroy');
        $scope.disconnect();
    });

    $scope.getConferenceAvatarUrl = function(alias, host) {
        return 'https://' + (host || document.domain) + '/api/client/v1/conferences/' + alias + '/avatar.jpg';
    };

    $scope.$on('call::pinRequested', function(event, required) {
        $log.debug('call::pinRequested', required);
        delete $scope.extensionRequested;
        $scope.loadingConference = false;
        if (angular.isDefined($scope.params.pin) || $scope.pinRequested) {
            $scope.call.connect($scope.params.pin);
            delete $scope.params.pin;
            $scope.loadingConference = true;
        }
        $scope.pinRequested = {
            required: required,
            role: required ? null : $scope.params.role || 'guest'
        };
    });

    $scope.$on('call::extensionRequested', function(event, required) {
        $log.debug('call::extensionRequested', required);
        $scope.loadingConference = false;
        if (angular.isDefined($scope.params.extension) || $scope.extensionRequested) {
            $scope.call.connect(null, $scope.params.extension);
            delete $scope.params.extension;
            $scope.loadingConference = true;
        }
        $scope.extensionRequested = {
            required: required
        };
    });

    if (platformSettings.isDesktopClient) {
        var currentWindow = require('nw.gui').Window.get();
        currentWindow.on('close', function() {
            currentWindow.hide();
            if ($scope.connection) {
                $scope.disconnect(true);
            }
            currentWindow.close(true);
        });
    }

    $scope.$on('call::disconnected', function(event, reason) {
        modal.alert('IDS_MESSAGE_DISCONNECTED', reason, function() {
            delete $scope.errorMessage;
            $scope.disconnect(true);
        });
    });

    $scope.$on('call::connected', function(event, data) {
        $timeout(function() {
            $scope.sendKeenEvent(
                'callConnected', {
                    uuid: data.uuid
                },
                data.analyticsEnabled);
            $log.debug('call::connected', data);

            $scope.connection.data = data;
            delete $scope.loadingConference;
            delete $scope.params.pin;
            $location.url($location.path());
            // window.history.pushState(null, 'any', $location.absUrl());
            // window.onpopstate = function(event) {
            //     $log.debug('window.onpopstate', event);
            //     $scope.$apply(function() {
            //         $scope.disconnect();
            //     });
            // };
        });
    });

    $scope.$on('call::error', function(event, reason) {
        $timeout(function() {
            $log.debug('call::error', reason);
            modal.close();
            $scope.setErrorMessage(reason);
            $scope.disconnect();
        });
    });
    $scope.$on('call::transfer', function(event, alias) {
        $log.debug('call::transfer', alias);
        $scope.connection.data.alias = alias;
    });
    $scope.$on('call::remoteMediaStream', function(event, stream, type) {
        $log.debug('call::remoteMediaStream', stream, type);
        delete $scope.connection.connectingMedia;
        switch (type) {
            case 'video':
                $scope.connection.remoteAudioStream = $sce.trustAsResourceUrl(stream);
                $scope.connection.remoteVideoStream = $sce.trustAsResourceUrl(stream);
                break;
            case 'rtmp':
                $scope.connection.remoteAudioStream = $sce.trustAsResourceUrl(stream);
                $scope.connection.remoteVideoStream = $sce.trustAsResourceUrl(stream);
                if ($localStorage.cameraSourceId !== false) {
                    $scope.connection.cameraEnabled = true;
                    $scope.connection.localVideoStream = $sce.trustAsResourceUrl(stream);
                }
                if (localStorage.microphoneSourceId !== false) {
                    $scope.connection.localAudioStream = $sce.trustAsResourceUrl(stream);
                }
                break;
            case 'audioonly':
                $scope.connection.remoteAudioStream = $sce.trustAsResourceUrl(stream);
                delete $scope.connection.remoteVideoStream;
        }
    });
    $scope.$on('call::localMediaStream', function(event, stream, type) {
        $log.debug('call::localMediaStream', stream, type);
        switch (type) {
            case 'video':
            case 'rtmp':
                if ($localStorage.cameraSourceId !== false) {
                    $scope.connection.cameraEnabled = true;
                    $scope.connection.localVideoStream = $sce.trustAsResourceUrl(stream);
                }
                if (localStorage.microphoneSourceId !== false) {
                    $scope.connection.localAudioStream = $sce.trustAsResourceUrl(stream);
                }
                break;
            case 'audioonly':
                if (localStorage.microphoneSourceId !== false) {
                    $scope.connection.localAudioStream = $sce.trustAsResourceUrl(stream);
                }
        }
    });
    $scope.$on('call::participantUpdate', function(event, participant) {
        if ($scope.connection.dialOutState && $scope.connection.dialOutState.result.indexOf(participant.uuid) !== -1) {
            $scope.connection.dialOutState.waiting.splice($scope.connection.dialOutState.waiting.indexOf(participant.uuid), 1);
            if (!participant.isConnecting) {
                $scope.connection.dialOutState.state = 'IDS_PARTICIPANT_ADD_CONNECTED';
                $scope.connection.participantAddDone();
            }
        }
        if (participant.uuid in $scope.connection.participants) {
            angular.copy(participant, $scope.connection.participants[participant.uuid]);
        } else {
            $scope.connection.participants[participant.uuid] = participant;
        }
        if ($scope.connection.data && participant.uuid === $scope.connection.data.uuid) {
            $scope.connection.participant = $scope.connection.participants[participant.uuid];
            $scope.connection.participant.isSelf = true;
        } else if (participant.isWaiting && $scope.connection.participant && participant.startTime > $scope.connection.participant.startTime) {
            $translate('IDS_MESSAGE_PARTICIPANT_WAITING', {
                displayName: participant.displayName
            }).then(toast.message);
        }
    });
    $scope.$on('call::participantDeleted', function(event, uuid) {
        $log.debug('call::participantDeleted', uuid);
        delete $scope.connection.participants[uuid];

        if ($scope.connection.dialOutState && $scope.connection.dialOutState.result.indexOf(uuid) !== -1) {
            $scope.connection.dialOutState.result.splice($scope.connection.dialOutState.result.indexOf(uuid), 1);
            if (!$scope.connection.dialOutState.result.length) {
                $scope.connection.dialOutState.state = 'IDS_PARTICIPANT_ADD_DISCONNECTED';
                $scope.connection.participantAddDone();
            }
        }
    });
    $scope.$on('call::participantAdd', function(event, participant) {
        $log.debug('call::participantAdd', participant);
        $scope.connection.dialOutState = participant;
        if (!participant.result.length) {
            $scope.connection.dialOutState.state = 'IDS_PARTICIPANT_ADD_FAILED';
            $scope.connection.participantAddDone();
        } else {
            $scope.connection.dialOutState.state = 'IDS_PARTICIPANT_ADD_CONNECTING';
        }
    });
    $scope.$on('call::stageUpdated', function(event, stage) {
        angular.copy(stage, $scope.connection.stage);
    });

    $scope.$on('call::presentationStarted', function(event, name) {
        var nameMatch = /(.*)\s<(.*)>/.exec(name);
        $translate('IDS_PRESENTATION_NAME', {
                displayName: nameMatch && (nameMatch[1] || nameMatch[2]) || name
            })
            .then(function(name) {
                $scope.call.presentationName = name;
                $scope.call.presentationMaximized = true;
            });
        if ($localStorage.fullMotionPresentationByDefault && platformSettings.hasWebRTC && applicationSettings.enableFullMotionPresentation) {
            $scope.call.startPresentationVideo();
        }
    });
    $scope.$on('call::presentationStopped', function(event) {
        $log.debug('call::presentationStopped');
        delete $scope.call.presentationName;
        delete $scope.call.presentationImgSrc;
        delete $scope.call.presentationVideoSrc;
    });

    $scope.$on('call::screenShareMissing', function(event, stage) {
        toggleService.toggle('dialog-screen-share-missing', true);
    });

    var lastMicActivity = 0;
    $scope.$on('call::onMicActivity', function(event) {
        if ($scope.call.microphoneMuted && (Date.now() - lastMicActivity > 30000)) {
            lastMicActivity = Date.now();
            $scope.micActivity = true;
            $timeout(function() {
                delete $scope.micActivity;
            }, 5000);
        }
    });


    if ($scope.params.join && !$scope.params.token) {
        $scope.login(
            $scope.params.conference,
            $scope.params.name,
            $scope.params.pin,
            undefined,
            $scope.params.extension);
    } else if ($scope.params.join && $scope.params.token) {
        $scope.login(
            $scope.params.conference,
            $scope.params.name,
            '',
            $scope.params.token);
    }
});
