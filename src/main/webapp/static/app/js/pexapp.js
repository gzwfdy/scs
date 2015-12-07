'use strict';

angular.module('pexapp', [
    'ngStorage',
    'pascalprecht.translate',
    'bernhardposselt.enhancetext',
    'pasvaz.bindonce'
])

.config(function($translateProvider) {
    $translateProvider.useStaticFilesLoader({
        prefix: 'languages/',
        suffix: '.json'
    });
    $translateProvider.registerAvailableLanguageKeys(['en-us', 'zh-cn'], {
        'en_*': 'en-us',

        'zh_*': 'zh-cn'
    });
    $translateProvider.determinePreferredLanguage();
    $translateProvider.useSanitizeValueStrategy('escaped');
    $translateProvider.fallbackLanguage('en-us');
    //$translateProvider.preferredLanguage('en-us');
    $translateProvider.useStorage('pexStorageService');
})

.config(['enhanceTextFilterProvider', function(enhanceTextFilterProvider) {
    enhanceTextFilterProvider.setOptions({
        cache: true, // stores replaced text so angular update does not slow down
        newLineToBr: true, // replaces \n with <br/>
        embedLinks: true, // replaces links with Html links
        embeddedLinkTarget: '_blank', // sets the target of all replaced links
        embedImages: true, // replaces links to images with Html images
        embedVideos: true, // replaces links to videos with Html videos
        embedYoutube: true, // replaces links to youtube videos with iframed youtube videos
        // embeddedYoutubeHeight: 157,
        // embeddedYoutubeWidth: 280,
        // embeddedImagesHeight: 157,
        // embeddedVideosHeight: 157
    });
}])

.config(function($animateProvider) {
    $animateProvider.classNameFilter(/ng-enable-animate/);
})

.run(function(
    $rootScope,
    $log,
    $localStorage,
    $translate,
    $location,
    platformSettings,
    applicationSettings,
    serverSettings,
    defaultUserSettings,
    callHistory,
    globalService) {

    $rootScope.platformSettings = platformSettings;
    $rootScope.applicationSettings = applicationSettings;
    $rootScope.serverSettings = serverSettings;
    $rootScope.callHistory = callHistory;
    $rootScope.globalService = globalService;

    $rootScope.loadRegPwd = loadRegPwd;
    $rootScope.saveRegPwd = saveRegPwd;

    if (!window.console) {
        window.console = {};
    }
    if (!window.console.log) {
        window.console.log = $log.log;
    }

    function isLocalStorageValid() {
        // TODO: FIXME: sanity check theme, language etc.
        if ($localStorage.settingsVersion === defaultUserSettings.settingsVersion) {
            return true;
        }
        return false;
    }

    if (!isLocalStorageValid()) {
        $log.debug(
            'Resetting local settings, due to settings version upgrade',
            $localStorage.settingsVersion,
            defaultUserSettings.settingsVersion);
        $localStorage.$reset();
    }
    $rootScope.localStorage = $localStorage.$default(defaultUserSettings);
        $rootScope.changeLanguage = function (langKey) {
            $translate.use(langKey);
        };
    //$translate.use($localStorage.language);

    $rootScope.params = angular.extend({}, {
        conference: $localStorage.conference,
        name: $localStorage.name,
    }, $location.search());
    if ($rootScope.params.role === 'guest') {
        $rootScope.params.pin = '';
    }

    if ($rootScope.params.bw && isFinite($rootScope.params.bw)) {
        $localStorage.defaultBandwidth = parseInt($rootScope.params.bw);
    }

    $rootScope.sendKeenEvent = function(collection, metadata, enabled) {
        if ($localStorage.analyticsReportingEnabled && enabled) {
            $log.debug("Sending usage data to keen.");
            $rootScope.keenApi = new Keen({
                projectId: platformSettings.keenProjectId,
                writeKey: platformSettings.keenWriteKey
            });
            var startEvent = {
                user_agent: "${keen.user_agent}",
                ip_address: "${keen.ip}",
                usedWidth: screen.availWidth,
                usedHeight: screen.availHeight,
                width: screen.width,
                height: screen.height,
                colorDepth: screen.colorDepth,
                pixelDepth: screen.pixelDepth,
                language: navigator.language || navigator.userLanguage,
                keen: {
                    timestamp: new Date().toISOString(),
                    addons: [
                        {
                            "name" : "keen:ua_parser",
                            "input" : { "ua_string" : "user_agent" },
                            "output" : "parsed_vendor"},
                        {
                            "name" : "keen:ip_to_geo",
                            "input" : {
                                "ip" : "ip_address"
                            },
                            "output" : "ip_geo_info"
                        }
                    ]
                }
            };
            if (metadata) {
                angular.extend(startEvent, metadata);
            }
            $rootScope.keenApi.addEvent(collection, startEvent);
        } else {
            $log.debug("Not sending usage data to keen. " +
                        applicationSettings.analyticsReportingEnabled);
        }
    };
})

.factory('pexStorageService', function($localStorage) {
    return {
        put: function(name, value) {
            // $localStorage.language = value;
        },
        get: function(name) {
            return $localStorage.language;
        }
    };
})

.filter('boolToHuman', function() {
    return function(val) {
        return val ? 'IDS_YES' : 'IDS_NO';
    };
})

.filter('values', function($filter) {
    return function(object) {
        var values = [];
        angular.forEach(object, function(value) {
            values.push(value);
        });
        return values;
    };
})

.filter('unsafe', function() {
    return function(value) {
        return value.toString();
    };
})

.filter('keyHumanReadable', [
    function() {
        return function(input) {
            var out = input.replace('_', ' ').replace('-', ' ');
            return out.charAt(0).toUpperCase() + out.slice(1);
        };
    }
])

.directive('pexVolume', function($log) {
    return {
        link: function($scope, element, attrs) {
            $scope.$watch(attrs.pexVolume, function(value) {
                $log.debug('Setting volume to', $scope.volume);
                element[0].volume = $scope.volume.value;
            });
        }
    };
})

.filter('numkeys', function() {
    return function(obj) {
        if (angular.isObject(obj)) {
            return Object.keys(obj).length;
        }
    };
});
