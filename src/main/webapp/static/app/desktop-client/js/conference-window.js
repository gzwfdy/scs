(function() {
    var gui = require('nw.gui');
    var conferenceWindow;

    global.openConferenceWindow = function(host, alias, displayName, token, direction) {
        if (conferenceWindow) {
            conferenceWindow.removeAllListeners('closed');
            conferenceWindow.close();
        }

        var title = alias + ' - ' + gui.App.manifest.name;
        host = host ? '&host=' + host : '';
        alias = '&conference=' + alias;
        displayName = displayName ? '&name=' + displayName : '';
        token = token ? '&token=' + token : '';
        direction = direction ? '&direction=' + direction : '';
        conferenceWindow = gui.Window.open(
            'index.conference.html#/?join=1' + host + alias + displayName + token + direction, {
                title: title,
                show: false,
                toolbar: false,
                frame: true,
                width: 900,
                height: 650,
                min_width: 450,
                min_height: 253,
                position: "center",
                icon: "configuration/favicon.png",
                focus: true
            });
        conferenceWindow.on('document-end', function() {
            conferenceWindow.title = title;
            conferenceWindow.show();
            conferenceWindow.focus();
        });
        conferenceWindow.on('closed', function() {
            conferenceWindow = null;
            global.openMainWindow();
        });
        conferenceWindow.on('new-win-policy', function(frame, url, policy) {
            gui.Shell.openExternal(url);
            policy.ignore();
        });
    };

    global.join = function(alias, displayName, pin, token) {
        console.log("JOIN", alias, displayName, pin, token);
        global.closeMainWindow();
        global.openConferenceWindow(undefined, alias, displayName, token);
    };
})();
