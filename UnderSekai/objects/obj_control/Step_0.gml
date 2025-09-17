if (global.dialogue_active) {
    // Avance letra a letra
    global.dialogue_timer++;
    if (global.dialogue_timer >= global.dialogue_speed && global.dialogue_index < string_length(global.dialogue_text)) {
        global.dialogue_index++;
        global.dialogue_timer = 0;
        audio_play_sound(global.dialogue_sound, 1, false);
    }

    // Avanzar diálogo con X
    if (keyboard_check_pressed(ord("X"))) {
        if (global.dialogue_index < string_length(global.dialogue_text)) {
            // Mostrar todo el texto instantáneamente
            global.dialogue_index = string_length(global.dialogue_text);
        } else {
            // Cerrar o mantener
            if (!global.dialogue_keep) {
                global.dialogue_active = false;
                obj_player.can_move = true;
                obj_usable.can_use = true;
            }
        }
    }
}
