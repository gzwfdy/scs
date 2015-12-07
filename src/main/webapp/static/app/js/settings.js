'use strict';
angular.module('pexapp')

.constant('platformSettings', {
    hasWebRTC: navigator.getUserMedia || navigator.mozGetUserMedia || navigator.webkitGetUserMedia || false,
    screenshareSupported: window.chrome && window.chrome.webstore || angular.isDefined(window.require),
    isDesktopClient: angular.isDefined(window.process) && window.process.platform,
    isAndroidClient: angular.isDefined(window.srv),
    volumeControlsEnabled: false,
    supportsVideo: true,
    keenProjectId: "557575d690e4bd6c1d8184e5",
    keenWriteKey: "3b7d272c6795270ebc07a922183c78bb5af84950fb4e21eea6fe46467dc1ee202f798833340ba9d97c2bb19c6de98379231f17da1a487d1ceabc37cd4836a3d61e0c5d4af6c156e66416cfadb97395b8f502507ae26cd3d1ebe1c81a3e7385a99b92a9db2faf72c8631b100d8ed25884"
})

.constant('applicationSettings', angular.extend({
    serverAddress: window.srv == undefined ? document.domain : null,

    dialOutProtocols: {
        'SIP': 'sip',
        'H.323': 'h323',
        'Lync/Skype': 'mssip',
        'RTMP': 'rtmp',
    },
    defaultDialOutProtocol: 'sip',

    registrationEnabled: angular.isDefined(window.require) || window.srv, //enable for desktop + android client

    bandwidths: [{
        name: 'IDS_BANDWIDTH_LOW',
        value: 192 + 64
    }, {
        name: 'IDS_BANDWIDTH_MEDIUM',
        value: 512 + 64
    }, {
        name: 'IDS_BANDWIDTH_HIGH',
        value: 1200 + 64
    }, {
        name: 'IDS_BANDWIDTH_MAXIMUM',
        value: 1800 + 64
    }],

    defaultDialOutRole: 'host', // 'host' or 'guest'

    enableFullMotionPresentation: true,

    languages: {
        //'English (US)': 'configuration/languages/en-us.json',
        // 'Norsk (Bokmål)': 'configuration/languages/no-nb.json' // Example additional language (make sure the language file exist)
    },

    themes: {
        'Default': 'configuration/themes/default',
        // 'Dark': 'configuration/themes/dark' // Example additional theme
    },

    ringtones: {
        'IDS_SETTINGS_DEFAULT': 'ringtones/default.wav'
    },

    // Uncomment the next line and specify an img path to override conference-avatar:
    // overrideConferenceAvatar: 'configuration/themes/default/conference-avatar.jpg',

    // Uncomment one of the next lines to specify a client-side TURN server to use
    // turnServer: { url: 'turn:turn.example.com', username: 'user', credential: 'pass' },
    // turnServer: { url: 'turn:turn.example.com:443?transport=tcp', username: 'user', credential: 'pass' },

    // Uncomment and reconfigure the next line if you use a customized screensharing extension
    // screenshareApi: 'pexGetScreen',
}, window.applicationSettings))

.constant('defaultUserSettings', angular.extend({
    theme: 'configuration/themes/default',
    //language: 'configuration/languages/zh-cn.json',
    ringtone: 'ringtones/default.wav',
    callHistory: {},
    promptDisconnect: true,
    startMedia: false,
    fullMotionPresentationByDefault: false,
    defaultBandwidth: 512 + 64,
    analyticsReportingEnabled: true,
    name: (window.process && (window.process.env.LOGNAME || window.process.env.USERNAME || window.process.USER)) || '',
    settingsVersion: 7, // Should be updated only if the keys change
}, window.defaultUserSettings))

.constant('serverSettings', {
    analyticsReportingEnabled: true,
});
