/// @function scr_dialogue_next()
/// Avanza al siguiente mensaje en la cola o cierra el diálogo si no hay más.
function scr_dialogue_next() {
    if (!variable_global_exists("dialogue_personajes")) return;
    if (global.dialogue_current < array_length(global.dialogue_mensajes)) {
        var i = global.dialogue_current;

        // Bloquear jugador/uso
        if (instance_exists(obj_player)) obj_player.can_move = false;
        if (instance_exists(obj_usable)) obj_usable.can_use = false;

        global.dialogue_active = true;
        global.dialogue_text = global.dialogue_mensajes[i];
        global.dialogue_index = 0;
        global.dialogue_timer = 0;
        global.dialogue_keep = global.dialogue_seguir[i];
        global.dialogue_character = global.dialogue_personajes[i];
        global.dialogue_face = global.dialogue_caras[i];

        // Sprite de cara si existe
        var face_name = "spr_" + string(global.dialogue_personajes[i]);
        var spr_id = asset_get_index(face_name);
        global.dialogue_sprite = (spr_id != -1) ? spr_id : noone;

        global.dialogue_current += 1;
    } else {
        // Fin de diálogo
        global.dialogue_active = false;
        if (instance_exists(obj_player)) obj_player.can_move = true;
        if (instance_exists(obj_usable)) obj_usable.can_use = false;

        global.dialogue_use_timer = 5;

        // Limpiar colas
        global.dialogue_personajes = [];
        global.dialogue_caras = [];
        global.dialogue_mensajes = [];
        global.dialogue_seguir = [];
        global.dialogue_current = 0;
    }
}
