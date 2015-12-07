var applicationSettings = {
    serverAddress: 'mcu.meetime.com',//window.srv == undefined ? document.domain : null, // Can be overridden with a host name or ip

    defaultDialOutProtocol: 'sip', // sip | h323 | mssip | rtmp

    languages: {
        //'English (US)': 'configuration/languages/en-us.json',
        // 'Norsk (Bokmål)': 'configuration/languages/no-nb.json' // Example additional language (make sure the language file exist)
    },

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

    // Uncomment the next line and specify an img path to override conference-avatar:
    // overrideConferenceAvatar: 'configuration/themes/default/conference-avatar.jpg',

    // Uncomment one of the next lines to specify a client-side TURN server to use
    // turnServer: { url: 'turn:turn.example.com', username: 'user', credential: 'pass' },
    // turnServer: { url: 'turn:turn.example.com:443?transport=tcp', username: 'user', credential: 'pass' },

    // Uncomment and reconfigure the next line if you use a customized screensharing extension
    // screenshareApi: 'pexGetScreen',
};

// Default configuration to apply to first-time users
var defaultUserSettings = {
    //language: 'zh-cn',

    defaultBandwidth: 512 + 64, // Make sure the value is in applicationSettings.bandwiths

    promptDisconnect: true,
    startMedia: false,
    analyticsReportingEnabled: true,
    fullMotionPresentationByDefault: false,
};
