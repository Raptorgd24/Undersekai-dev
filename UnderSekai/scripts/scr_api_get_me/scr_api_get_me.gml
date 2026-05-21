function scr_api_get_me() {
    var _url = global.api_base + "/v1/me";
    var _headers = ds_map_create();
    ds_map_add(_headers, "Authorization", "Bearer " + global.api_token);
    var _req = http_request(_url, "GET", _headers, "");
    ds_map_add(global.api_pending, _req, "getme");
    ds_map_destroy(_headers);
    return _req;
}