// Seguridad: si la API no responde en ~8s, continuar igualmente (evita cuelgue)
if (!api_done && !fading) {
    api_timeout++;
    if (api_timeout > game_get_speed(gamespeed_fps) * 8) {
        show_debug_message("obj_endphone: la API no respondio a tiempo, se continua.");
        api_done = true;
        fading   = true;
    }
}

if (fading) {
    fade_alpha = min(fade_alpha + fade_speed, 1);
    if (fade_alpha >= 1) {
        room_goto(rm_ending);
    }
}