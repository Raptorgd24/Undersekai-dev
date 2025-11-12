// STEP EVENT
show_debug_message("Estado: " + string(intro_state) + ", Texto: " + string(intro_current_text));
// Toggle pantalla completa con F4
/*if (keyboard_check_pressed(vk_f4)) {
    if (!window_get_fullscreen()) {
        window_set_fullscreen(true);
    } else {
        window_set_fullscreen(false);
    }
}*/
// SKIP GLOBAL - Cualquier Z o Enter activa el fade final Y el fade de música
if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {
    show_debug_message("SKIP ACTIVADO - Iniciando fades");
    if (intro_state != "final_fade") {
        intro_state = "final_fade";
        fade_alpha = 0;
        music_fading = true;
        music_volume = 1;
    }
}

// Fade out de la música si está activo
if (music_fading) {
    music_volume -= music_fade_speed;
    if (music_volume <= 0) {
        music_volume = 0;
        audio_stop_sound(mus_doomsday);
    } else {
        // Aplicar volumen reducido a la música
        audio_sound_gain(mus_doomsday, music_volume, 0);
    }
}

// Si estamos en fade final
if (intro_state == "final_fade") {
    fade_alpha += fade_speed;
    
    // Cambiar de room solo cuando ambos fades estén completos
    if (fade_alpha >= 1 && music_volume <= 0) {
        room_goto(rm_MainMenu);
    }
    exit;
}

// Procesar estado normal (solo si no estamos en fade final)
switch (intro_state) {
    case "writing":
        intro_char_timer++;
        if (intro_char_timer >= intro_char_delay) {
            intro_char_timer = 0;
            var current_text = intro_texts[intro_current_text];
            if (intro_char_index < string_length(current_text)) {
                intro_char_index++;
                intro_display_text = string_copy(current_text, 1, intro_char_index);
                
                // Sonido de texto
                if (audio_is_playing(snd_txt2)) audio_stop_sound(snd_txt2);
                audio_play_sound(snd_txt2, 1, false);
                
            } else {
                intro_state = "waiting";
                intro_char_timer = -60; // 2 segundos de pausa
            }
        }
    break;
    
    case "waiting":
        intro_char_timer++;
        if (intro_char_timer >= 0) {
            // Verificar si hay más textos
            if (intro_current_text < array_length(intro_texts) - 1) {
                // Siguiente texto
                intro_current_text++;
                intro_char_index = 0;
                intro_display_text = "";
                intro_state = "writing";
                
                // Cambiar sprite inmediatamente
                if (intro_current_text < array_length(intro_sprites)) {
                    current_sprite = intro_sprites[intro_current_text];
                }
                
            } else {
                // Último texto, iniciar fade final Y fade de música
                intro_state = "final_fade";
                fade_alpha = 0;
                music_fading = true;
                music_volume = 1;
            }
        }
    break;
}