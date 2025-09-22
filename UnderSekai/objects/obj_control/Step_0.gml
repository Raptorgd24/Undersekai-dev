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
    if (keyboard_check_pressed(ord("Z")) || keyboard_check(vk_enter)) {
        if (global.dialogue_index >= string_length(global.dialogue_text)) {
            scr_dialogue_next();
            // Bloquear X por 1 frame
            global.dialogue_x_cooldown = 1;
        }
    }

    // Mostrar todo el texto instantáneamente con X
    if (keyboard_check_pressed(ord("X")) && global.dialogue_x_cooldown <= 0 || keyboard_check(vk_shift)) && global.dialogue_x_cooldown <= 0  {
        global.dialogue_index = string_length(global.dialogue_text);
    }
}

	if (keyboard_check(vk_f4)){
	if (!window_get_fullscreen()) {
    window_set_fullscreen(true);  // Activar pantalla completa
	} else {
    window_set_fullscreen(false); // Volver a modo ventana
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

// Solo si hay datos de evento activos
if (!is_undefined(global.event_datalol)) {
    // Comprobar que aún hay pasos que ejecutar
    if (global.event_step < array_length_1d(global.event_datalol)) {
        var entry = global.event_datalol[global.event_step];

        if (!is_undefined(entry)) {
            var target_time = entry[0];
            var action = entry[1];

            // Si es la marca especial "after_dialogue"
            if (is_string(target_time) && target_time == "after_dialogue") {
                var use_ready = !variable_global_exists("dialogue_use_timer") || global.dialogue_use_timer <= 0;
                if (!global.dialogue_active && use_ready) {
                    action();
                    global.event_step++;
                }
            } else if (is_real(target_time)) {
                // Programación por frames (numérica)
                if (!variable_global_exists("event_time")) global.event_time = -1;
                global.event_time++;
                if (global.event_time >= target_time) {
                    action();
                    global.event_step++;
                }
            }
        }
    }
}
