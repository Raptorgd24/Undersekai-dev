function scr_api_init() {
    if (variable_global_exists("api_token")) {
        return;
    }
    global.api_base = "http://localhost:3000";
    global.api_token = "";
    global.api_logged_in = false;
    global.api_username = "";
    global.api_pending = ds_map_create();
}