// --------------------- STEP ---------------------
if (global.dialogue_active) {
    // Avance letra a letra
    global.dialogue_timer++;
    if (global.dialogue_timer >= global.dialogue_speed && global.dialogue_index < string_length(global.dialogue_text)) {
        global.dialogue_index++;
        global.dialogue_timer = 0;
        if (global.dialogue_sound != -1) {
            audio_play_sound(global.dialogue_sound, 1, false);
        }
    }

    if (!variable_global_exists("dialogue_x_cooldown")) {
        global.dialogue_x_cooldown = 0;
    }

    if (global.dialogue_x_cooldown > 0) {
        global.dialogue_x_cooldown -= 1;
    }

    if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {
        if (global.dialogue_index >= string_length(global.dialogue_text)) {
            scr_dialogue_next();
            
            global.dialogue_x_cooldown = 1;
        }
    }

    if ((keyboard_check_pressed(ord("X")) && global.dialogue_x_cooldown <= 0) || (keyboard_check_pressed(vk_shift) && global.dialogue_x_cooldown <= 0)) {
        global.dialogue_index = string_length(global.dialogue_text);
    }
}

if (shake_timer <= 0){	
	if (shake_layer != -1)
	layer_set_visible("Shake", false);
} else{
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

if (variable_global_exists("waiting_for_walk") && global.waiting_for_walk) {
    if (instance_exists(global.event_npc) && !global.event_npc.NPCmoving) {
        show_debug_message("[Event System] NPC terminó de caminar, continuando evento");
        global.waiting_for_walk = false;
        
        scr_dialogue("sans", 0, "anyway kid...", true,false);
        scr_dialogue("sans", 0, "i-i think im close-", true,false);
        scr_dialogue("sans", 0, "oh no... i'm about to-", false,false);
        
        global.event_datalol = [
            ["after_dialogue", function() {
                obj_player.can_move = false;
                obj_usable.can_use = false;
                show_debug_message("[Event System] Fase 3: Sonido sansing");
                audio_play_sound(snd_sansing, 1, false);
                global.boom_wait_frames = 42;
                global.waiting_for_boom = true;
            }]
        ];
        global.event_step = 0;
        global.event_time = -1;
    }
}

if (variable_global_exists("waiting_for_boom") && global.waiting_for_boom) {
    if (global.boom_wait_frames > 0) {
        global.boom_wait_frames--;
        if (global.debug && global.boom_wait_frames % 10 == 0) {
            show_debug_message("[Event System] Frames restantes para boom: " + string(global.boom_wait_frames));
        }
    } else {
        show_debug_message("[Event System] ¡Espera completada! Creando explosión");
        global.waiting_for_boom = false;
        
        if (instance_exists(global.event_npc)) {
            var boom = instance_create_layer(global.event_npc.x - 20, global.event_npc.y - 20, "Instances_1", obj_boom_temp);
            boom.parent_npc = global.event_npc;
            audio_play_sound(snd_boom, 1, false);
            audio_stop_sound(snd_sansing);
            scr_dialogue("noone", 8, "...", true,false);
            scr_dialogue("noone", 8, "What the fuck...", false,true);
            
            global.event_datalol = [
                ["after_dialogue", function() {
                    show_debug_message("[Event System] Fase 4: Fin del evento");
					array_push(global.events_done, "Test");
                    obj_player.can_move = true;
                    obj_usable.can_use = true;
                    global.event_npc = noone;
                    if (variable_global_exists("waiting_for_boom")) global.waiting_for_boom = false;
                    if (variable_global_exists("boom_wait_frames")) global.boom_wait_frames = 0;
                }]
            ];
            global.event_step = 0;
            global.event_time = -1;
        }
    }
}

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
if (variable_global_exists("song_inst") && global.song_inst != noone) {
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
                    if (idx != -1) _next_asset = idx;
                    else _next_asset = -1;
                }
                if (_next_asset != -1) {
                    global.song_asset = _next_asset;
                    global.song_inst  = audio_play_sound(global.song_asset, 1, true);
                    audio_sound_gain(global.song_inst, 0, 0);
                    global.song_volume = 0;
                    global.song_target = 1;
                    global.song_next = noone;
                } else {
                    show_debug_message("⚠ scr_musictrans: song_next inválida: " + string(global.song_next));
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

global.play_time += delta_time / 1000000;