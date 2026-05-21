if (!ds_map_exists(global.api_pending, async_load[? "id"])) exit;

var _type = ds_map_find_value(global.api_pending, async_load[? "id"]);
ds_map_delete(global.api_pending, async_load[? "id"]);

if (_type != "login") exit;

waiting_req = false;
status_msg  = "";

var _status = async_load[? "http_status"];
var _body   = async_load[? "result"];

if (_status == 200) {
    var _json = json_parse(_body);

    if (variable_struct_exists(_json, "token")) {
        global.api_token     = _json.token;
        global.api_username  = username_input;
        global.api_logged_in = true;

        ini_open("options.ini");
        ini_write_string("account", "token",    global.api_token);
        ini_write_string("account", "username", global.api_username);
        ini_close();

        room_goto(rm_options);
    } else {
        error_msg = "Respuesta inesperada del servidor.";
        state     = "username";
    }
} else {
    var _msg = "Error " + string(_status);
    if (_body != "") {
        var _parsed = json_parse(_body);
        if (variable_struct_exists(_parsed, "message")) {
            _msg = _parsed.message;
        }
    }
    error_msg = _msg;
    state     = "username";
    input_cooldown = 10;
}