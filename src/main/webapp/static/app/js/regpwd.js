(function(window) {
    function encrypt(key, password) {
        return JSON.stringify(window.btoa(unescape(encodeURIComponent(password))));
    }
    function decrypt(key, password) {
        return decodeURIComponent(escape(window.atob(JSON.parse(password))));
    }

    function loadRegPwd() {
        var encrypted = localStorage['ngStorage-registrationPassword'];
        return encrypted ? decrypt(null, encrypted) : '';
    }

    function saveRegPwd(password) {
        localStorage['ngStorage-registrationPassword'] = encrypt(null, password || '');
    }

    window.loadRegPwd = loadRegPwd;
    window.saveRegPwd = saveRegPwd;
})(this);
