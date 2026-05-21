function scr_api_login(_email, _password) {
    var _url = global.api_base + "/v1/user/login";
    
    show_debug_message("=== LOGIN START ===");
    show_debug_message("URL: " + string(_url));
    show_debug_message("EMAIL: " + string(_email));
    show_debug_message("PASSWORD LENGTH: " + string(string_length(_password)));

    var _body = json_stringify({
        email: _email,
        password: _password
    });

    show_debug_message("BODY JSON: " + string(_body));

    var _headers = ds_map_create();
    ds_map_add(_headers, "Content-Type", "application/json");

    show_debug_message("HEADERS CREATED");

    var _req = http_request(_url, "POST", _headers, _body);

    show_debug_message("REQUEST ID: " + string(_req));

    ds_map_add(global.api_pending, _req, "login");

    show_debug_message("REQUEST ADDED TO PENDING");
    show_debug_message("=== LOGIN REQUEST SENT ===");

    ds_map_destroy(_headers);

    return _req;
}
