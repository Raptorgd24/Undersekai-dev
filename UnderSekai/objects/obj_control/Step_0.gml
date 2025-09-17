if (global.dialogue_active) {
    // Avance letra a letra
    global.dialogue_timer++;
    if (global.dialogue_timer >= global.dialogue_speed && global.dialogue_index < string_length(global.dialogue_text)) {
        global.dialogue_index++;
        global.dialogue_timer = 0;
        audio_play_sound(global.dialogue_sound, 1, false);
    }

    // Mostrar todo el texto instantáneamente con X
    if (keyboard_check_pressed(ord("X"))) {
        global.dialogue_index = string_length(global.dialogue_text);
    }

    // Avanzar diálogo con Z
    if (keyboard_check_pressed(ord("Z"))) {
        if (global.dialogue_index >= string_length(global.dialogue_text)) {
            // Cerrar o pasar al siguiente diálogo
            if (!global.dialogue_keep) {
                global.dialogue_active = false;
                obj_player.can_move = true;
                obj_usable.can_use = true;
            } else {
                // Aquí podrías llamar a la función para el siguiente diálogo
                // Ejemplo: next_dialogue();
            }
        }
    }
}
