function scr_api_login(_email, _password) {
    var _url = global.api_base + "/v1/login";
    var _body = json_stringify({
        email: _email,
        password: _password
    });
    var _headers = ds_map_create();
    ds_map_add(_headers, "Content-Type", "application/json");
    var _req = http_request(_url, "POST", _headers, _body);
    ds_map_add(global.api_pending, _req, "login");
    ds_map_destroy(_headers);
    return _req;
}