/// @function scr_dialogue_next()
/// Avanza al siguiente mensaje en la cola o cierra el diálogo si no hay más.
function scr_dialogue_next() {
    if (!variable_global_exists("dialogue_personajes")) return;
    if (global.dialogue_current < array_length(global.dialogue_mensajes)) {
        var i = global.dialogue_current;

        // Bloquear al jugador / interacción
        if (instance_exists(obj_player)) obj_player.can_move = false;
        if (instance_exists(obj_usable)) obj_usable.can_use = false;

        global.dialogue_active = true;
        global.dialogue_text   = global.dialogue_mensajes[i];
        global.dialogue_index  = 0;
        global.dialogue_timer  = 0;
        global.dialogue_keep   = global.dialogue_seguir[i];
        global.dialogue_character = global.dialogue_personajes[i];
        global.dialogue_face   = global.dialogue_caras[i];

        // --- Sprite de cara ---
        var char_name = string(global.dialogue_personajes[i]);
        var face_name = "spr_" + char_name;
        var spr_id = asset_get_index(face_name);
        global.dialogue_sprite = (spr_id != -1) ? spr_id : noone;

        // --- Fuente y sonido ---
        var default_font  = asset_get_index("ft_determinationmono");
        var default_sound = asset_get_index("snd_txt1");

        // Fuente personalizada
        var font_name = "ft_" + char_name;
        var font_id = asset_get_index(font_name);
        if (font_id != -1) {
            global.dialogue_font = font_id;
        } else if (default_font != -1) {
            global.dialogue_font = default_font;
        }

        // Sonido personalizado
        var snd_name = "snd_" + char_name;
        var snd_id = asset_get_index(snd_name);
        if (snd_id != -1) {
            global.dialogue_sound = snd_id;
        } else if (default_sound != -1) {
            global.dialogue_sound = default_sound;
        }

        // Pasar al siguiente mensaje
        global.dialogue_current += 1;
    } else {
        // Fin del diálogo
        global.dialogue_active = false;
        if (instance_exists(obj_player)) obj_player.can_move = true;
        if (instance_exists(obj_usable)) obj_usable.can_use = false;

        global.dialogue_use_timer = 5;

        // Limpiar
        global.dialogue_personajes = [];
        global.dialogue_caras      = [];
        global.dialogue_mensajes   = [];
        global.dialogue_seguir     = [];
        global.dialogue_current    = 0;
    }
}
