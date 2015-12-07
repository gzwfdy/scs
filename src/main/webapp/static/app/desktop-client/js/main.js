if (process.platform === 'darwin') {
    var gui = require('nw.gui');

    var menuBar = new gui.Menu({
        type: "menubar"
    });
    menuBar.createMacBuiltin(gui.App.manifest.name);
    gui.Window.get().menu = menuBar;
}

(function() {
    var gui = require('nw.gui');
    var mainWindow;
    var width = 400;
    var height = 500;

    global.openMainWindow = function() {
        if (!mainWindow) {
            mainWindow = gui.Window.open(
                'index.main.html', {
                    title: gui.App.manifest.name,
                    show: false,
                    toolbar: false,
                    frame: true,
                    width: width,
                    height: height,
                    min_width: width,
                    min_height: 300,
                    position: "center",
                    icon: 'configuration/favicon.png',
                    focus: true,
                });
            mainWindow.on('document-end', function() {
                mainWindow.title = gui.App.manifest.name;
                mainWindow.show();
                mainWindow.focus();
            });
            mainWindow.on('closed', function() {
                mainWindow = null;
            });
            mainWindow.on('new-win-policy', function(frame, url, policy) {
                gui.Shell.openExternal(url);
                policy.ignore();
            });
        } else {
            mainWindow.show();
            mainWindow.focus();
        }
    };

    global.closeMainWindow = function() {
        if (mainWindow) {
            mainWindow.close();
            mainWindow = null;
        }
    };
})();

(function() {
    var gui = require('nw.gui');

    function getConferenceUri(argv) {
        var result;
        var re = /pexip:(\S+)/i;
        argv.forEach(function(arg) {
            var match = re.exec(arg);
            if (match) {
                result = match[1];
            }
        });
        return result;
    }

    function main(argv) {
        console.log("main: argv", argv);
        var conferenceUri = argv && getConferenceUri(argv);
        console.log("main: conferenceUri", conferenceUri);
        if (conferenceUri) {
            global.join(conferenceUri);
        } else {
            global.openMainWindow();
        }
    }

    gui.App.on('open', function(cmdline) {
        console.log("App.on('open')", cmdline);
        var argv = cmdline.split(/\s/);
        main(argv);
    });

    gui.App.on('reopen', function(argv) {
        console.log("App.on('reopen')", argv);
        main(argv);
    });

    gui.Window.get().on('loaded', function() {
        main(gui.App.argv);
    });
})();
