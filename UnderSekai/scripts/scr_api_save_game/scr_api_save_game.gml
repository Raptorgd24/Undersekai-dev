function scr_api_save_game(_charaName, _playTime, _route) {
    var _url = global.api_base + "/v1/savefile";
    var _body = json_stringify({
        charaName: _charaName,
        playTime: _playTime,
        route: _route
    });

    show_debug_message("=== SAVEFILE START ===");
    show_debug_message("URL: " + string(_url));
    show_debug_message("LOGGED IN: " + string(variable_global_exists("api_logged_in") ? global.api_logged_in : "?"));
    show_debug_message("TOKEN PRESENTE: " + string(global.api_token != "") + " (len " + string(string_length(global.api_token)) + ")");
    show_debug_message("charaName: '" + string(_charaName) + "' (len " + string(string_length(string(_charaName))) + ")");
    show_debug_message("playTime (microsegundos): " + string(_playTime));
    show_debug_message("route: '" + string(_route) + "'");
    show_debug_message("BODY JSON: " + string(_body));

    // Avisos de validacion que el backend rechazaria con 400 "Faltan datos de partida"
    if (string(_charaName) == "" || string(_charaName) == "EMPTY") show_debug_message("AVISO: charaName vacio/EMPTY -> el backend respondera 400");
    if (is_undefined(_playTime))                                   show_debug_message("AVISO: playTime undefined -> el backend respondera 400");
    if (string(_route) == "")                                      show_debug_message("AVISO: route vacio -> el backend respondera 400");
    if (global.api_token == "")                                    show_debug_message("AVISO: sin token -> el middleware de auth respondera 401");

    var _headers = ds_map_create();
    ds_map_add(_headers, "Content-Type", "application/json");
    ds_map_add(_headers, "Authorization", "Bearer " + global.api_token);

    var _req = http_request(_url, "POST", _headers, _body);

    show_debug_message("REQUEST ID: " + string(_req));
    show_debug_message("=== SAVEFILE REQUEST SENT ===");

    ds_map_add(global.api_pending, _req, "savefile");
    ds_map_destroy(_headers);
    return _req;
}