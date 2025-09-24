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
    if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {
        if (global.dialogue_index >= string_length(global.dialogue_text)) {
            scr_dialogue_next();
            // Bloquear X por 1 frame
            global.dialogue_x_cooldown = 1;
        }
    }

    // Mostrar todo el texto instantáneamente con X
    if (keyboard_check_pressed(ord("X")) && global.dialogue_x_cooldown <= 0 || keyboard_check_pressed(vk_shift)) && global.dialogue_x_cooldown <= 0  {
        global.dialogue_index = string_length(global.dialogue_text);
    }
}

	if (keyboard_check_pressed(vk_f4)){
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

// --- Manejo de transición ---
if (global.trans_active) {
    switch (global.trans_state) {
        case 0: // Fundido a negro
            global.trans_alpha += trans_speed;
            if (global.trans_alpha >= 1) {
                global.trans_alpha = 1;
                room_goto(global.trans_target);
                global.trans_state = 1;
            }
        break;

        case 1: // Espera un frame tras cambiar room
            global.trans_state = 2;
        break;

        case 2: // Fundido de regreso
            global.trans_alpha -= trans_speed;
            if (global.trans_alpha <= 0) {
                global.trans_alpha = 0;
                global.trans_active = false;
				obj_player.can_move = true;
            }
        break;
    }
}

// --- controlador de volumen para la música ---
if (variable_global_exists("song")) {
    if (global.song_volume != global.song_target) {
        global.song_volume = lerp(global.song_volume, global.song_target, global.song_speed);

        // aplicamos al sonido actual
        if (audio_exists(global.song)) {
            audio_sound_gain(global.song, global.song_volume, 0);
        }

        // cuando se completa el fade out
        if (global.song_volume <= 0.01 && global.song_target == 0) {
            audio_stop_sound(global.song);

            // reproducimos la siguiente con fade in
            if (variable_global_exists("song_next")) {
                global.song = audio_play_sound(global.song_next, 1, true);
                audio_sound_gain(global.song, 0, 0);
                global.song_target = 1;
                global.song_speed  = global.song_speed; // mismo valor de fade
                global.song_next   = noone;
            }
        }
    }
}
