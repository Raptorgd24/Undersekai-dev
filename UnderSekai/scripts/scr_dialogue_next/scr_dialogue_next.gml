function scr_dialogue_next() {
    if (global.dialogue_current < array_length(global.dialogue_mensajes)) {
        var i = global.dialogue_current;

        obj_player.can_move = false;
        obj_usable.can_use = false;

        global.dialogue_active = true;
        global.dialogue_text = global.dialogue_mensajes[i];
        global.dialogue_index = 0;
        global.dialogue_timer = 0;
        global.dialogue_keep = global.dialogue_seguir[i];
        global.dialogue_character = global.dialogue_personajes[i];

        var spr_face = asset_get_index("spr_" + global.dialogue_personajes[i]);
        global.dialogue_sprite = (spr_face != -1) ? spr_face : noone;
        global.dialogue_face = global.dialogue_caras[i];

        var ft = asset_get_index("ft_" + global.dialogue_personajes[i]);
        global.dialogue_font = (ft != -1) ? ft : ft_determinationmono;

        var snd = asset_get_index("snd_" + string_lower(global.dialogue_personajes[i]));
        global.dialogue_sound = (snd != -1) ? snd : snd_txt1;

        global.dialogue_current += 1;

    } else {
        // Fin del diálogo: cerrar visualmente
        global.dialogue_active = false;
        obj_player.can_move = true;
        obj_usable.can_use = false;

        // Iniciar timer de 5 frames para habilitar uso
        global.dialogue_use_timer = 5;

        // Limpiar arrays
        global.dialogue_personajes = [];
        global.dialogue_caras = [];
        global.dialogue_mensajes = [];
        global.dialogue_seguir = [];
        global.dialogue_current = 0;
    }
}
