'use strict';
/* global $ */

if (window.AudioContext) {
    var audioContext = new window.AudioContext();
    var analyser = audioContext.createAnalyser();
    analyser.fftSize = 1024;
    analyser.smoothingTimeConstant = 0.5;
}

angular.module('pexapp')

.controller('userMediaPreview', function($scope, $rootScope, $localStorage, $sce, $timeout, $interval, $log, flashVideo) {
    navigator.getUserMedia = (navigator.getUserMedia ||
        navigator.webkitGetUserMedia ||
        navigator.mozGetUserMedia ||
        navigator.msGetUserMedia);

    var mediaStreamSource;
    var audioInterval;

    var flashMicrophoneTimeout;
    var flashMicrophoneInterval;
    var flashElement;

    $log.debug('Creating handler for flash::ready');
    var offFlashReady = $rootScope.$on('flash::ready', function() {
        /* global swfobject */
        $log.debug('flash::ready');
        flashElement = swfobject.getObjectById($scope.flashPreviewId);
        $log.debug('Flash Preview Element', $scope.flashPreviewId, flashElement);
        flashElement.setSelfviewRatio(1);
        flashElement.initCamera($localStorage.cameraSourceId);
        flashElement.initMicrophone($localStorage.microphoneSourceId);
        flashElement.showSelfview();

        $scope.mediaSources = {
            audio: [],
            video: []
        };
        angular.forEach(flashElement.enumerateVideoSources(), function(label, id) {
            $scope.mediaSources.video.push({
                id: id,
                label: label,
                kind: 'video'
            });
        });
        angular.forEach(flashElement.enumerateAudioSources(), function(label, id) {
            if (label !== 'Default') {
                $scope.mediaSources.audio.push({
                    id: id,
                    label: label,
                    kind: 'audio'
                });
            }
        });

        flashMicrophoneInterval = $interval(function() {
            try {
                var mediaStats = flashElement.getMediaStatistics();
                $scope.microphoneVolume = mediaStats.Outgoing.Audio.Level;
            } catch (e) {
                $log.debug(e);
                $interval.cancel(flashMicrophoneInterval);
            }
        }, 500);

        offFlashReady();
    });

    function releaseUserMedia() {
        $log.debug('calling releaseUserMedia()');
        delete $scope.getUserMediaError;
        $scope.mediaSources = {
            audio: [],
            video: []
        };

        $log.debug('Stopping WebRTC audio interval');
        $interval.cancel(audioInterval);
        $scope.microphoneVolume = 0;

        if (mediaStreamSource) {
            mediaStreamSource.disconnect();
            mediaStreamSource = null;
        }

        if (analyser) {
            analyser.disconnect();
        }

        if ($scope.localMediaStream) {
            $log.debug('Stopping localMediaStream');
            var tracks = $scope.localMediaStream.getTracks();
            for (var i=0;i<tracks.length;i++) {
                tracks[i].stop();
            }
        }
    }

    function getMediaSources() {
        var getSources = window.MediaStreamTrack.getSources || function(callback) {
            // callback(localMediaStream.getVideoTracks().concat(localMediaStream.getAudioTracks()));
            callback([]);
        };
        getSources(function(sources) {
            $timeout(function() {
                $scope.mediaSources.audio = $.grep(sources, function(source) {
                    return source.label && source.label !== 'Default' && source.kind === 'audio';
                });
                $scope.mediaSources.video = $.grep(sources, function(source) {
                    return source.label && source.label !== 'Default' && source.kind === 'video';
                });
                $scope.mediaSources.video.push({
                    id: false,
                    kind: 'video',
                    label: 'IDS_SETTINGS_CAMERA_NONE'
                });
                $scope.mediaSources.audio.push({
                    id: false,
                    kind: 'audio',
                    label: 'IDS_SETTINGS_MICROPHONE_NONE'
                });
            });
        });
    }


    function getWebRtcUserMedia() {
        if (audioContext && angular.isFunction(audioContext.resume)) {
            audioContext.resume();
        }

        var constraints = {};

        if ($localStorage.cameraSourceId !== false) {
            constraints.video = {
                optional: [{
                    sourceId: $localStorage.cameraSourceId
                }, {
                    minWidth: 320
                }, {
                    minWidth: 640
                }, {
                    minWidth: 1024
                }, {
                    minWidth: 1280
                }]
            };
        }
        if ($localStorage.microphoneSourceId !== false) {
            constraints.audio = {
                optional: [{
                    sourceId: $localStorage.microphoneSourceId
                }]
            };
        }

        $log.debug('getUserMedia', constraints);
        if (!constraints.video && !constraints.audio) {
            getMediaSources();
            $scope.videoStreamName = 'IDS_SETTINGS_CAMERA_NONE';
            $scope.audioStreamName = 'IDS_SETTINGS_MICROPHONE_NONE';
        } else {
            navigator.getUserMedia(constraints,
                function(localMediaStream) {
                    $timeout(function() {
                        var url = window.URL || window.webkitURL || window.mozURL;
                        $scope.localMediaStream = localMediaStream;
                        $scope.localMediaStreamURL = $sce.trustAsResourceUrl(url.createObjectURL($scope.localMediaStream));
                        $log.debug('gotUserMedia', $scope);
                    });

                    getMediaSources();

                    var videoTracks = localMediaStream.getVideoTracks();
                    $scope.videoStreamName = videoTracks.length ? videoTracks[0].label.replace(/\(.*\)/, '') || 'IDS_SETTINGS_CAMERA_DEFAULT' : 'IDS_SETTINGS_CAMERA_NONE';
                    var audioTracks = localMediaStream.getAudioTracks();
                    $scope.audioStreamName = audioTracks.length ? audioTracks[0].label || 'IDS_SETTINGS_MICROPHONE_DEFAULT' : 'IDS_SETTINGS_MICROPHONE_NONE';

                    if (window.AudioContext) {
                        try {
                            mediaStreamSource = audioContext.createMediaStreamSource(localMediaStream);
                            mediaStreamSource.connect(analyser);

                            $log.debug('Creating WebRTC audio interval');

                            audioInterval = $interval(function() {
                                if (audioContext.state === 'suspended') {
                                    audioContext.resume();
                                }
                                var array = new Uint8Array(analyser.frequencyBinCount);
                                analyser.getByteFrequencyData(array);
                                var values = 0;

                                var length = array.length;
                                for (var i = 0; i < length; i++) {
                                    values += array[i];
                                }
                                $timeout(function() {
                                    $scope.microphoneVolume = (values / length);
                                });
                            }, 100);

                            analyser.disconnect();
                        } catch (e) {
                            $log.debug('Failed to create media stream source for audio context', e);
                        }
                    }
                },
                function(err) {
                    $log.error('getUserMedia failed', err);
                    $scope.mediaSources = {
                        audio: [{
                            id: false,
                            kind: 'audio',
                            label: 'IDS_SETTINGS_MICROPHONE_NONE'
                        }],
                        video: [{
                            id: false,
                            kind: 'video',
                            label: 'IDS_SETTINGS_CAMERA_NONE'
                        }]
                    };
                    $scope.getUserMediaError = err.name;
                    $localStorage.microphoneSourceId = false;
                    $localStorage.cameraSourceId = false;
                }
            );
        }
    }

    function getFlashUserMedia() {
        flashElement.initCamera($localStorage.cameraSourceId);
        flashElement.initMicrophone($localStorage.microphoneSourceId);
        flashElement.setSelfviewRatio(1);
        flashElement.showSelfview();
    }

    $scope.previewUserMedia = function() {
        if (navigator.getUserMedia) {
            releaseUserMedia();
            $timeout(getWebRtcUserMedia, 500);
        } else if (flashElement) {
            getFlashUserMedia();
        }
    };

    $scope.previewUserMedia();

    $scope.$on('$destroy', function(event) {
        $interval.cancel(flashMicrophoneInterval);
        offFlashReady();
        releaseUserMedia();
        if (audioContext && angular.isFunction(audioContext.suspend)) {
            audioContext.suspend();
        }
    });
})

.directive('muted', function() {
    return {
        link: function(scope, element, attrs) {
            element[0].muted = true;
        }
    };
});
