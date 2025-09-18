// --------------------- STEP ---------------------
if (global.dialogue_active) {
    // Avance letra a letra
    global.dialogue_timer++;
    if (global.dialogue_timer >= global.dialogue_speed && global.dialogue_index < string_length(global.dialogue_text)) {
        global.dialogue_index++;
        global.dialogue_timer = 0;
        audio_play_sound(global.dialogue_sound, 1, false);
    }

    // Inicializar cooldown de X si no existe
    if (!variable_global_exists("dialogue_x_cooldown")) {
        global.dialogue_x_cooldown = 0;
    }

    // Reducir cooldown de X
    if (global.dialogue_x_cooldown > 0) {
        global.dialogue_x_cooldown -= 1;
    }

    // Avanzar diálogo con Z
    if (keyboard_check_pressed(ord("Z"))) {
        if (global.dialogue_index >= string_length(global.dialogue_text)) {
            dialogue_next();
            // Bloquear X por 1 frame
            global.dialogue_x_cooldown = 1;
        }
    }

    // Mostrar todo el texto instantáneamente con X
    if (keyboard_check_pressed(ord("X")) && global.dialogue_x_cooldown <= 0) {
        global.dialogue_index = string_length(global.dialogue_text);
    }
}

// Timer para habilitar uso después de 5 frames
if (variable_global_exists("dialogue_use_timer") && global.dialogue_use_timer > 0) {
    global.dialogue_use_timer -= 1;
    if (global.dialogue_use_timer <= 0) {
        obj_usable.can_use = true;
        global.dialogue_use_timer = 0;
    }
}
