function scr_api_logout() {
    global.api_token     = "";
    global.api_username  = "";
    global.api_logged_in = false;

    ini_open("options.ini");
    ini_write_string("account", "token",    "");
    ini_write_string("account", "username", "");
    ini_close();
}