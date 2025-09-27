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
    if ((keyboard_check_pressed(ord("X")) && global.dialogue_x_cooldown <= 0) || (keyboard_check_pressed(vk_shift) && global.dialogue_x_cooldown <= 0)) {
        global.dialogue_index = string_length(global.dialogue_text);
    }
}

// Toggle pantalla completa con F4
if (keyboard_check_pressed(vk_f4)) {
    if (!window_get_fullscreen()) {
        window_set_fullscreen(true);
    } else {
        window_set_fullscreen(false);
    }
}

// Timer para habilitar uso después de 5 frames
if (variable_global_exists("dialogue_use_timer") && global.dialogue_use_timer > 0) {
    global.dialogue_use_timer -= 1;
    if (global.dialogue_use_timer <= 0) {
        if (instance_exists(obj_usable)) obj_usable.can_use = true;
        global.dialogue_use_timer = 0;
    }
}

// Sistema de eventos mejorado
if (!is_undefined(global.event_datalol) && is_array(global.event_datalol)) {
    if (global.event_step < array_length(global.event_datalol)) {
        var entry = global.event_datalol[global.event_step];
        
        if (!is_undefined(entry)) {
            var target_time = entry[0];
            var action = entry[1];

            if (is_string(target_time) && target_time == "after_dialogue") {
                // Esperar a que termine el diálogo y que no haya cooldown activo
                var dialogue_finished = !global.dialogue_active;
                var use_ready = !variable_global_exists("dialogue_use_timer") || global.dialogue_use_timer <= 0;
                
                if (dialogue_finished && use_ready) {
                    show_debug_message("[Event System] Ejecutando acción post-diálogo");
                    action();
                    global.event_step++;
                    global.event_time = -1; // Reset timer
                }
            } else if (is_real(target_time)) {
                if (!variable_global_exists("event_time")) global.event_time = -1;
                global.event_time++;
                
                if (global.event_time >= target_time) {
                    show_debug_message("[Event System] Ejecutando acción en frame " + string(global.event_time));
                    action();
                    global.event_step++;
                    global.event_time = -1; // Reset timer después de acción numérica
                }
            }
        }
    } else {
        // Limpiar evento cuando termina
        global.event_datalol = undefined;
        global.event_step = 0;
        global.event_time = -1;
        show_debug_message("[Event System] Evento completado y limpiado");
    }
}

// Sistema de espera para caminata de NPC
if (variable_global_exists("waiting_for_walk") && global.waiting_for_walk) {
    if (instance_exists(global.event_npc) && !global.event_npc.NPCmoving) {
        show_debug_message("[Event System] NPC terminó de caminar, continuando evento");
        global.waiting_for_walk = false;
        
        // Continuar con la siguiente fase del evento
        scr_dialogue("sans", 0, "anyway kid...", true);
        scr_dialogue("sans", 0, "i-i think im close-", true);
        scr_dialogue("sans", 0, "oh no... i'm about to-", false);
        
        // Programar el resto del evento
        global.event_datalol = [
            ["after_dialogue", function() {
                show_debug_message("[Event System] Fase 3: Sonido sansing");
                audio_play_sound(snd_sansing, 1, false);
                
                // Iniciar contador de espera para el boom (50 frames)
                global.boom_wait_frames = 50;
                global.waiting_for_boom = true;
                show_debug_message("[Event System] Iniciando espera de 50 frames para boom");
            }]
        ];
        global.event_step = 0;
        global.event_time = -1;
    }
}

// Sistema de espera para el boom (50 frames) - AÑADIR ESTO NUEVO
if (variable_global_exists("waiting_for_boom") && global.waiting_for_boom) {
    if (global.boom_wait_frames > 0) {
        global.boom_wait_frames--;
        
        // Debug cada 10 frames
        if (global.debug && global.boom_wait_frames % 10 == 0) {
            show_debug_message("[Event System] Frames restantes para boom: " + string(global.boom_wait_frames));
        }
    } else {
        // ¡Tiempo cumplido! Crear la explosión
        show_debug_message("[Event System] ¡Espera completada! Creando explosión");
        global.waiting_for_boom = false;
        
        if (instance_exists(global.event_npc)) {
            var boom = instance_create_layer(global.event_npc.x - 20, global.event_npc.y - 20, "Instances_1", obj_boom_temp);
            boom.parent_npc = global.event_npc;
            audio_play_sound(snd_boom, 1, false);
            
            // Diálogos después de la explosión
            scr_dialogue("noone", 8, "...", true);
            scr_dialogue("noone", 8, "What the fuck...", false);
            
            // Final del evento
            global.event_datalol = [
                ["after_dialogue", function() {
                    show_debug_message("[Event System] Fase 4: Fin del evento");
                    obj_player.can_move = true;
                    obj_usable.can_use = true;
                    global.event_npc = noone;
                    
                    // Limpiar variables de espera
                    if (variable_global_exists("waiting_for_boom")) {
                        global.waiting_for_boom = false;
                    }
                    if (variable_global_exists("boom_wait_frames")) {
                        global.boom_wait_frames = 0;
                    }
                }]
            ];
            global.event_step = 0;
            global.event_time = -1;
        }
    }
}
// --- Manejo de transición ---
if (global.trans_active) {
    switch (global.trans_state) {
        case 0: // Fundido a negro
            global.trans_alpha += global.trans_speed;
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
            global.trans_alpha -= global.trans_speed;
            if (global.trans_alpha <= 0) {
                global.trans_alpha = 0;
                global.trans_active = false;
                if (instance_exists(obj_player)) obj_player.can_move = true;
                if (instance_exists(obj_usable)) obj_usable.can_use = true;
            }
        break;
    }
}

// --- controlador de volumen para la música ---
if (variable_global_exists("song_inst") && global.song_inst != noone) {
    global.song_fade_delta = 1 / max(1, global.song_fade_frames);

    if (global.song_volume != global.song_target) {
        // avanzar volumen hacia target con paso fijo
        if (global.song_target > global.song_volume) {
            global.song_volume += global.song_fade_delta;
            if (global.song_volume > global.song_target) global.song_volume = global.song_target;
        } else {
            global.song_volume -= global.song_fade_delta;
            if (global.song_volume < global.song_target) global.song_volume = global.song_target;
        }

        // aplicar al sonido actual si sigue vivo
        if (audio_is_playing(global.song_inst)) {
            audio_sound_gain(global.song_inst, clamp(global.song_volume, 0, 1), 0);
        } else {
            global.song_inst = noone;
        }

        // cuando se completa el fade out (0) -> detener e iniciar siguiente si existe
        if (global.song_volume <= 0.001 && global.song_target == 0) {
            if (audio_is_playing(global.song_inst)) audio_stop_sound(global.song_inst);
            global.song_inst = noone;

            // reproducimos la siguiente con fade in si hay cola
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
        // si no está cambiando el volumen, aseguramos que el gain coincide
        if (audio_is_playing(global.song_inst)) {
            audio_sound_gain(global.song_inst, clamp(global.song_volume, 0, 1), 0);
        }
    }
}

// --------------------- DRAW GUI (Dialog System) ---------------------
if (variable_global_exists("dialogue_active") && global.dialogue_active) {

    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();
    var margin = 16;

    // Sprite caja
    var spr_idx = asset_get_index("spr_dialoguebox");
    var box_w = (spr_idx != -1) ? sprite_get_width(spr_idx) : (gui_w - margin*2);
    var box_h_default = 80;

    // Texto visible hasta ahora
    var visible_text = string_copy(global.dialogue_text, 1, global.dialogue_index);

    // --- función local: word wrap ---
    function _string_wrap(_text, _wrap_width) {
        var lines = [];
        if (_text == "") return lines;

        var words = string_split(_text, " ");
        var line = "";

        for (var i = 0; i < array_length(words); i++) {
            var w = words[i];
            var test = (line == "") ? w : line + " " + w;

            if (string_width(test) > _wrap_width) {
                if (line != "") {
                    array_push(lines, line);
                    line = w;
                } else {
                    // cortar palabra larga
                    var rest = w;
                    while (string_length(rest) > 0) {
                        var c = 1;
                        while (c <= string_length(rest) && string_width(string_copy(rest, 1, c)) <= _wrap_width) {
                            c += 1;
                        }
                        if (c == 1) {
                            array_push(lines, string_copy(rest, 1, 1));
                            rest = string_copy(rest, 2, string_length(rest)-1);
                        } else {
                            array_push(lines, string_copy(rest, 1, c-1));
                            rest = string_copy(rest, c, string_length(rest)-(c-1));
                        }
                    }
                    line = "";
                }
            } else {
                line = test;
            }
        }
        if (line != "") array_push(lines, line);
        return lines;
    }

    // --- Posición según cámara ---
    var use_legacy = true;
    if (instance_exists(obj_player)) {
        var cam = view_camera[0];
        if (!is_undefined(cam) && cam != -1) {
            var view_y = camera_get_view_y(cam);
            var view_h = camera_get_view_height(cam);
            var cam_mid_y = view_y + view_h/2;
            use_legacy = (obj_player.y < cam_mid_y);
        } else if (instance_exists(obj_cam)) {
            use_legacy = (obj_player.y < obj_cam.y);
        }
    }

    // Coordenadas originales
    var legacy_box_x = 0;
    var legacy_box_y = 105;
    var legacy_face_x = 54;
    var legacy_face_y = 350;
    var legacy_text_x_with_face = 160;
    var legacy_text_x_no_face   = 64;
    var legacy_text_y = 340;

    // Offset si no hay sprite o es noone
    var extra_offset = 0;
    var extra_margin = 0;
    var char_name = (variable_global_exists("dialogue_character") ? string(global.dialogue_character) : "noone");
    if (global.dialogue_sprite == noone || char_name == "noone") {
        extra_offset = -100;
        extra_margin = 100;
    }

    // Calcular posiciones
    var base_x, base_y, face_x, face_y, text_x, text_y;
    if (use_legacy) {
        base_x = legacy_box_x;
        base_y = legacy_box_y;
        face_x = legacy_face_x;
        face_y = legacy_face_y;
        text_x = (global.dialogue_sprite != noone) ? legacy_text_x_with_face : legacy_text_x_no_face;
        text_y = legacy_text_y;
    } else {
        base_x = legacy_box_x;
        base_y = legacy_box_y - 300;
        face_x = legacy_face_x;
        face_y = legacy_face_y - 300;
        text_x = (global.dialogue_sprite != noone) ? legacy_text_x_with_face : legacy_text_x_no_face;
        text_y = legacy_text_y - 300;
    }
    text_x += extra_offset;

    // Wrap width
    var rel_text_x = text_x - base_x;
    if (rel_text_x < 0) rel_text_x = margin;
    var wrap_w = box_w - rel_text_x - 32 - extra_margin;
    if (wrap_w < 40) wrap_w = box_w - margin*2;

    // Generar líneas
    var lines = _string_wrap(visible_text, wrap_w);

    // Altura texto y caja
    var line_h = string_height("Ay");
    var padding_v = 12;
    var text_block_h = max(1, array_length(lines)) * line_h;
    var box_h = (spr_idx != -1) ? sprite_get_height(spr_idx) : (text_block_h + padding_v*2);

    // Dibujar caja
    if (spr_idx != -1) {
        draw_sprite(spr_idx, 0, base_x, base_y);
    } else {
        draw_set_alpha(0.9);
        draw_rectangle(base_x, base_y, base_x + box_w, base_y + box_h, false);
        draw_set_alpha(1);
    }

    // Dibujar cara
    var face_sprite = global.dialogue_sprite;
    if (face_sprite != noone) {
        draw_sprite_ext(face_sprite, global.dialogue_face, face_x, face_y, 2.3, 2.3, 0, $FFFFFF, 1);
    }

    // --- Fuente ---
    var font_to_use = (variable_global_exists("dialogue_font") ? global.dialogue_font : -1);
    if (is_undefined(font_to_use) || font_to_use == -1) {
        var df = asset_get_index("ft_determinationmono");
        if (df != -1) draw_set_font(df);
    } else if (is_string(font_to_use)) {
        var idx = asset_get_index(font_to_use);
        draw_set_font((idx != -1) ? idx : asset_get_index("ft_determinationmono"));
    } else {
        draw_set_font(font_to_use);
    }

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    // --- Texto estilo Undertale: * + margen 32 ---
    var start_x = text_x;
    var start_y = text_y;
    draw_set_color(c_white);
    for (var li = 0; li < array_length(lines); li++) {
        var line_str = lines[li];
        if (li == 0) {
            draw_text(start_x, start_y, "*");
            draw_text(start_x + 32, start_y, line_str);
        } else {
            draw_text(start_x + 32, start_y + li * line_h, line_str);
        }
    }

    // Indicador de "continuar"
    if (!global.dialogue_keep && global.dialogue_index >= string_length(global.dialogue_text)) {
        var cx = base_x + box_w - 32 - 12;
        var cy = base_y + box_h - margin - 8;
        draw_triangle(cx, cy, cx+8, cy, cx+4, cy+8, false);
    }
}

// Debug info
if (global.debug) {
    draw_set_color(c_lime);
    draw_text(32, 24, "Zona: " + string(global.current_zone));
    draw_text(32, 48, "Event Step: " + string(global.event_step));
    draw_text(32, 72, "Dialogue Active: " + string(global.dialogue_active));
    draw_text(32, 96, "Event Data: " + string(!is_undefined(global.event_datalol)));
    if (variable_global_exists("waiting_for_walk")) {
        draw_text(32, 120, "Waiting Walk: " + string(global.waiting_for_walk));
    }
    if (variable_global_exists("event_time")) {
        draw_text(32, 144, "Event Time: " + string(global.event_time));
    }
    
    draw_set_color(c_white);
}

// --- Dibujar transición ---
if (global.trans_active) {
    draw_set_alpha(global.trans_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);
}