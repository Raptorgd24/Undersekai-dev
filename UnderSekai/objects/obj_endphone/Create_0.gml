scr_api_init();

fade_alpha = 0;
fade_speed = 1 / 180;
fading = false;
api_done = false;
api_timeout = 0; // contador de seguridad por si la API no responde

if (instance_exists(obj_player)) obj_player.can_move = false;
if (instance_exists(obj_usable)) obj_usable.can_use = false;

scr_save_game();

// Solo subir a la API si hay una sesion iniciada con token valido.
// Sin esto, la peticion sale con "Bearer " vacio y el servidor la rechaza (no sube).
if (variable_global_exists("api_logged_in") && global.api_logged_in
    && variable_global_exists("api_token") && global.api_token != "") {

    pending_req = scr_api_save_game(global.name, global.play_time, global.route);

} else {
    show_debug_message("obj_endphone: sin sesion API (sin token), se omite la subida y se continua.");
    pending_req = -1;
    api_done    = true;
    fading      = true; // continuar al ending igualmente
}