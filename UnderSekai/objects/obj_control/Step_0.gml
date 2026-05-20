// --------------------- STEP ---------------------
dialogue_update(); // Usar el nuevo manager

if (global.dialogue_manager.active) {
    // Avance de texto o selección de opciones
    if (!global.dialogue_manager.waiting_for_choice) {
        if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {
            if (global.dialogue_manager.text_index >= string_length(global.dialogue_manager.current_dialogue.messages[global.dialogue_manager.current_index - 1].text)) {
                dialogue_next();
            }
        }
        if ((keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift))) {
            global.dialogue_manager.text_index = string_length(global.dialogue_manager.current_dialogue.messages[global.dialogue_manager.current_index - 1].text);
        }
    } else {
        // Navegar opciones
        if (keyboard_check_pressed(vk_up)) {
			audio_play_sound(snd_menumove, 1, false, 0.7);
            global.dialogue_manager.selected_choice = max(0, global.dialogue_manager.selected_choice - 1);
        }
        if (keyboard_check_pressed(vk_down)) {
			
			audio_play_sound(snd_menumove, 1, false, 0.7);
            global.dialogue_manager.selected_choice = min(array_length(global.dialogue_manager.choices) - 1, global.dialogue_manager.selected_choice + 1);
        }
        if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {
			audio_play_sound(snd_select, 1, false, 0.7);
            dialogue_select_choice(global.dialogue_manager.selected_choice);
        }
    }
}

if (shake_timer <= 0){	
	if (shake_layer != -1)
		if (layer_exists("Shake"))
		layer_set_visible("Shake", false)
		else{
		layer_create(1,"Shake")
		layer_set_visible("Shake", false)
		}
} 
else{
	shake_timer--	
}




if (variable_global_exists("dialogue_use_timer") && global.dialogue_use_timer > 0) {
    global.dialogue_use_timer -= 1;
    if (global.dialogue_use_timer <= 0) {
        if (instance_exists(obj_usable)) obj_usable.can_use = true;
        global.dialogue_use_timer = 0;
    }
}

if (!is_undefined(global.event_datalol) && is_array(global.event_datalol)) {
    if (global.event_step < array_length(global.event_datalol)) {
        var entry = global.event_datalol[global.event_step];
        
        if (!is_undefined(entry)) {
            var target_time = entry[0];
            var action = entry[1];

            if (is_string(target_time) && target_time == "after_dialogue") {
                var dialogue_finished = !global.dialogue_active;
                var use_ready = !variable_global_exists("dialogue_use_timer") || global.dialogue_use_timer <= 0;
                
                if (dialogue_finished && use_ready) {
                    show_debug_message("[Event System] Ejecutando acción post-diálogo");
                    action();
                    global.event_step++;
                    global.event_time = -1;
                }
            } else if (is_real(target_time)) {
                if (!variable_global_exists("event_time")) global.event_time = -1;
                global.event_time++;
                
                if (global.event_time >= target_time) {
                    show_debug_message("[Event System] Ejecutando acción en frame " + string(global.event_time));
                    action();
                    global.event_step++;
                    global.event_time = -1;
                }
            }
        }
    } else {
        global.event_datalol = undefined;
        global.event_step = 0;
        global.event_time = -1;
        show_debug_message("[Event System] Evento completado y limpiado");
    }
}

event_update(); // Usar el nuevo manager de eventos

if (global.trans_active) {
    switch (global.trans_state) {
        case 0:
            global.trans_alpha += global.trans_speed;
            if (global.trans_alpha >= 1) {
                global.trans_alpha = 1;
                room_goto(global.trans_target);
                global.trans_state = 1;
            }
        break;

        case 1:
            global.trans_state = 2;
			obj_player.visible = true;
				obj_player.x =_x;
				obj_player.y =_y;
        break;

        case 2:
            global.trans_alpha -= global.trans_speed;
            if (global.trans_alpha <= 0) {
                global.trans_alpha = 0;
                global.trans_active = false;
                obj_player.can_move = true;
                obj_usable.can_use = true;

            }
        break;
    }
}

if (variable_instance_exists(id, "requested_song") && !is_undefined(requested_song) && requested_song != noone) {
    // Asegurar globals necesarios
    if (!variable_global_exists("song_fade_frames")) global.song_fade_frames = 60;
    if (!variable_global_exists("song_fade_delta")) global.song_fade_delta = 1 / max(1, global.song_fade_frames);
    if (!variable_global_exists("song_target")) global.song_target = 1;

    // Asignar la petición a la cola
    global.song_next = requested_song;


    // Si hay una canción sonando, forzamos fade out (target = 0) para que el sistema detenga y encole la siguiente.
    // Si no hay canción activa, dejamos target = 1 para que el bloque de reproducción directa la inicie.
    if (variable_global_exists("song_inst") && global.song_inst != noone && audio_is_playing(global.song_inst)) {
        global.song_target = 0; // -> el Step ya existente hará fade out y luego iniciará global.song_next
        show_debug_message("obj_control: petición de música recibida (fade out): " + string(global.song_next));
    } else {
        // No hay instancia activa -> iniciarla directamente en el bloque que ya existe más abajo
        global.song_target = 1;
        show_debug_message("obj_control: petición de música recibida (reproducción directa): " + string(global.song_next));
    }

    // Limpiar variables de solicitud
    requested_song = noone;
}

// --- controlador de volumen para la música ---
if (variable_global_exists("song_inst")) {
    if (global.song_inst == noone) {
        if (variable_global_exists("song_next") && global.song_next != noone) {
            var _next = global.song_next;
            if (is_string(_next)) {
                var _idx = asset_get_index(_next);
                _next = (_idx != -1) ? _idx : -1;
            }
            if (_next != -1) {
                global.song_asset  = _next;
                global.song_inst   = audio_play_sound(global.song_asset, 1, true);
                audio_sound_gain(global.song_inst, 0, 0);
                global.song_volume = 0;
                global.song_target = 1;
                global.song_next   = noone;
            }
        } else if (variable_global_exists("song_asset") && global.song_asset != noone) {
            global.song_inst   = audio_play_sound(global.song_asset, 1, true);
            audio_sound_gain(global.song_inst, global.song_volume, 0);
        }
    } else {
        global.song_fade_delta = 1 / max(1, global.song_fade_frames);

        if (global.song_volume != global.song_target) {
            if (global.song_target > global.song_volume) {
                global.song_volume += global.song_fade_delta;
                if (global.song_volume > global.song_target) global.song_volume = global.song_target;
            } else {
                global.song_volume -= global.song_fade_delta;
                if (global.song_volume < global.song_target) global.song_volume = global.song_target;
            }

            if (audio_is_playing(global.song_inst)) {
                audio_sound_gain(global.song_inst, clamp(global.song_volume, 0, 1), 0);
            } else {
                global.song_inst = noone;
            }

            if (global.song_volume <= 0.001 && global.song_target == 0) {
                if (audio_is_playing(global.song_inst)) audio_stop_sound(global.song_inst);
                global.song_inst = noone;

                if (variable_global_exists("song_next") && global.song_next != noone) {
                    var _next_asset = global.song_next;
                    if (is_string(_next_asset)) {
                        var idx = asset_get_index(_next_asset);
                        _next_asset = (idx != -1) ? idx : -1;
                    }
                    if (_next_asset != -1) {
                        global.song_asset  = _next_asset;
                        global.song_inst   = audio_play_sound(global.song_asset, 1, true);
                        audio_sound_gain(global.song_inst, 0, 0);
                        global.song_volume = 0;
                        global.song_target = 1;
                        global.song_next   = noone;
                    } else {
                        global.song_next = noone;
                    }
                }
            }
        } else {
            if (audio_is_playing(global.song_inst)) {
                audio_sound_gain(global.song_inst, clamp(global.song_volume, 0, 1), 0);
            }
        }
    }
}

global.play_time += delta_time;