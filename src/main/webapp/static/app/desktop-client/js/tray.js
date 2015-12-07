(function() {
    var gui = require('nw.gui');
    var path = require('path');
    var fs = require('fs');

    var trayIconDefault = 'configuration/favicon.png';
    var trayIconGreen = path.join(gui.App.dataPath, 'tray-green.png');
    var trayIconRed = path.join(gui.App.dataPath, 'tray-red.png');

    var iconImg = new Image();
    iconImg.src = "../configuration/favicon.png";
    iconImg.onload = function() {
        var greenImg = new Image();
        greenImg.src = '../configuration/green.svg';
        greenImg.onload = function() {
            var canvas = document.createElement('canvas');
            canvas.height = canvas.width = '16';
            var ctx = canvas.getContext('2d');
            ctx.drawImage(iconImg, 0, 0, canvas.width, canvas.height);
            ctx.drawImage(greenImg, 0, 0, canvas.width, canvas.height);
            var imgData = canvas.toDataURL('image/png');
            var data = imgData.replace(/^data:image\/\w+;base64,/, "");
            fs.writeFile(trayIconGreen, new Buffer(data, 'base64'));
        };

        var redImg = new Image();
        redImg.src = '../configuration/red.svg';
        redImg.onload = function() {
            var canvas = document.createElement('canvas');
            canvas.height = canvas.width = '16';
            var ctx = canvas.getContext('2d');
            ctx.drawImage(iconImg, 0, 0, canvas.width, canvas.height);
            ctx.drawImage(redImg, 0, 0, canvas.width, canvas.height);
            var imgData = canvas.toDataURL('image/png');
            var data = imgData.replace(/^data:image\/\w+;base64,/, "");
            fs.writeFile(trayIconRed, new Buffer(data, 'base64'));
        };
    };

    var menu = new gui.Menu();

    menu.append(new gui.MenuItem({
        type: 'normal',
        label: 'Open',
        click: function() {
            global.openMainWindow();
        }
    }));

    menu.append(new gui.MenuItem({
        type: 'separator',
    }));

    menu.append(new gui.MenuItem({
        type: 'normal',
        label: 'Open Dev Tools',
        click: function() {
            gui.Window.get().showDevTools();
        }
    }));

    menu.append(new gui.MenuItem({
        type: 'separator',
    }));

    menu.append(new gui.MenuItem({
        type: 'normal',
        label: 'Quit',
        click: function() {
            global.unregister(function() {
                gui.App.closeAllWindows();
            });
        }
    }));

    var tray = new gui.Tray({
        icon: trayIconDefault,
        iconsAreTemplates: false,
        menu: menu,
        tooltip: gui.App.manifest.name
    });

    tray.on('click', function() {
        global.openMainWindow();
    });

    global.setTrayIconDefault = function() {
        tray.icon = trayIconDefault;
    };
    global.setTrayIconRed = function() {
        tray.icon = trayIconRed;
    };
    global.setTrayIconGreen = function() {
        tray.icon = trayIconGreen;
    };
})();
