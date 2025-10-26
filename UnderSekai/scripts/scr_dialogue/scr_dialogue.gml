function scr_dialogue(_personaje, _cara, _mensaje, _seguir, _move) {
    
    if (!variable_global_exists("dialogue_personajes")) global.dialogue_personajes = [];
    if (!variable_global_exists("dialogue_caras")) global.dialogue_caras = [];
    if (!variable_global_exists("dialogue_mensajes")) global.dialogue_mensajes = [];
    if (!variable_global_exists("dialogue_seguir")) global.dialogue_seguir = [];
    if (!variable_global_exists("liberar_move")) global.liberar_move = true;

    array_push(global.dialogue_personajes, _personaje);
    array_push(global.dialogue_caras, _cara);
    array_push(global.dialogue_mensajes, _mensaje);
    array_push(global.dialogue_seguir, _seguir);
    global.liberar_move = _move	

    if (!variable_global_exists("dialogue_active") || !global.dialogue_active) {
        global.dialogue_current = 0;
        scr_dialogue_next();
    }
}
