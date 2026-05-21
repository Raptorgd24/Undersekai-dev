function scr_api_init() {
    if (variable_global_exists("api_token")) return;
    global.api_base    = "http://localhost:3000";
    global.api_token   = "";
    global.api_logged_in = false;
    global.api_username  = "";
    global.api_pending = ds_map_create();

    ini_open("options.ini");
    var _saved_token    = ini_read_string("account", "token",    "");
    var _saved_username = ini_read_string("account", "username", "");
    ini_close();

    if (_saved_token != "") {
        global.api_token      = _saved_token;
        global.api_username   = _saved_username;
        global.api_logged_in  = true;
    }
}