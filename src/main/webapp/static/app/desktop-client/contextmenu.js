angular.module('pexapp')

.directive('input', function($translate) {
    var gui = require('nw.gui');
    return {
        restrict: 'E',
        link: function link(scope, element, attrs) {
            if (attrs.type === 'text') {
                var menu = new gui.Menu();
                menu.append(new gui.MenuItem({
                    label: $translate.instant('IDS_DESKTOPCLIENT_MENU_CUT'),
                    click: function() {
                        document.execCommand('cut');
                    }
                }));
                menu.append(new gui.MenuItem({
                    label: $translate.instant('IDS_DESKTOPCLIENT_MENU_COPY'),
                    click: function() {
                        document.execCommand('copy');
                    }
                }));
                menu.append(new gui.MenuItem({
                    label: $translate.instant('IDS_DESKTOPCLIENT_MENU_PASTE'),
                    click: function() {
                        document.execCommand('paste');
                    }
                }));

                element[0].addEventListener('contextmenu', function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    menu.popup(e.x, e.y);
                    return false;
                });
            }
        }
    };
})

.directive('body', function($timeout, $translate) {
    var gui = require('nw.gui');
    return {
        restrict: 'E',
        link: function link(scope, element, attrs) {
            $timeout(function() {
                $translate(['IDS_DESKTOPCLIENT_MENU_SHOW_DEV_TOOLS', 'IDS_DESKTOPCLIENT_MENU_ALWAYS_ON_TOP'])
                    .then(function(translations) {
                        var menu = new gui.Menu();
                        menu.append(new gui.MenuItem({
                            type: 'checkbox',
                            label: translations.IDS_DESKTOPCLIENT_MENU_ALWAYS_ON_TOP,
                            click: function() {
                                gui.Window.get().setAlwaysOnTop(this.checked);
                            }
                        }));
                        menu.append(new gui.MenuItem({
                            label: translations.IDS_DESKTOPCLIENT_MENU_SHOW_DEV_TOOLS,
                            click: function() {
                                gui.Window.get().showDevTools();
                            }
                        }));

                        element[0].addEventListener('contextmenu', function(e) {
                            e.preventDefault();
                            e.stopPropagation();
                            menu.popup(e.x, e.y);
                            return false;
                        });
                    }, function() {
                        console.error('Failed to add context menu');
                    });
            }, 500); // 500ms timeout to wait for translations needed here :/
        }
    };
});
