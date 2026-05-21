function scr_api_save_game(_charaName, _playTime, _route) {
    var _url = global.api_base + "/v1/savefile";
    var _body = json_stringify({
        charaName: _charaName,
        playTime: _playTime,
        route: _route
    });
    var _headers = ds_map_create();
    ds_map_add(_headers, "Content-Type", "application/json");
    ds_map_add(_headers, "Authorization", "Bearer " + global.api_token);
    var _req = http_request(_url, "POST", _headers, _body);
    ds_map_add(global.api_pending, _req, "savefile");
    ds_map_destroy(_headers);
    return _req;
}