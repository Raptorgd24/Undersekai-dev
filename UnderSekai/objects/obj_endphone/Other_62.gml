if (!variable_global_exists("api_pending")) exit;
if (!ds_map_exists(global.api_pending, async_load[? "id"])) exit;

var req_type = ds_map_find_value(global.api_pending, async_load[? "id"]);
ds_map_delete(global.api_pending, async_load[? "id"]);

if (req_type == "savefile") {
    var _status = async_load[? "http_status"];   // codigo HTTP del servidor
    var _body   = async_load[? "result"];        // body de la respuesta
    var _httpid = async_load[? "id"];

    show_debug_message("=== SAVEFILE RESPONSE ===");
    show_debug_message("REQUEST ID: " + string(_httpid));
    show_debug_message("HTTP STATUS: " + string(_status));
    show_debug_message("BODY: " + string(_body));

    if (_status == 200 || _status == 201) {
        show_debug_message("RESULTADO: savefile subido correctamente (ok).");
    } else if (_status == 400) {
        show_debug_message("RESULTADO: 400 -> el backend dice 'Faltan datos de partida' (charaName/playTime/route).");
    } else if (_status == 401 || _status == 403) {
        show_debug_message("RESULTADO: " + string(_status) + " -> problema de autenticacion (token invalido o ausente).");
    } else {
        show_debug_message("RESULTADO: error " + string(_status) + " (revisar servidor).");
    }
    show_debug_message("=== END SAVEFILE RESPONSE ===");

    // En cualquier caso continuamos al ending para no bloquear el juego.
    api_done = true;
    fading   = true;
}