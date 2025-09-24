function scr_musictrans(_new_song, _fade_frames) {
    if (!variable_global_exists("song_volume")) global.song_volume = 1;
    if (!variable_global_exists("song_target")) global.song_target = 1;
    if (!variable_global_exists("song_fade_frames")) global.song_fade_frames = 60;

    if (argument_count > 1 && !is_undefined(_fade_frames) && _fade_frames > 0) {
        global.song_fade_frames = _fade_frames;
        global.song_fade_delta = 1 / max(1, global.song_fade_frames);
    }

    // Normalizar asset
    var _new_res = _new_song;
    if (is_string(_new_song)) {
        var idx = asset_get_index(_new_song);
        _new_res = (idx != -1) ? idx : -1;
        if (_new_res == -1) show_debug_message("⚠ scr_musictrans: asset no encontrado para: " + string(_new_song));
    }

    // Si hay canción sonando, hacemos fade out y encolamos la nueva
    if (variable_global_exists("song_inst") && global.song_inst != noone && audio_is_playing(global.song_inst)) {
        global.song_next = _new_res;
        global.song_target = 0; // fade out
    } else {
        // Si no hay canción, arrancamos la nueva directamente
        if (_new_res != -1) {
            global.song_asset = _new_res;
            global.song_inst = audio_play_sound(global.song_asset, 1, true);
            if (audio_is_playing(global.song_inst)) {
                audio_sound_gain(global.song_inst, 0, 0);
                global.song_volume = 0;
                global.song_target = 1;
            } else {
                show_debug_message("⚠ scr_musictrans: fallo al reproducir asset: " + string(_new_res));
                global.song_inst = noone;
            }
        } else {
            show_debug_message("⚠ scr_musictrans: _new_res inválido: " + string(_new_res));
            global.song_inst = noone;
        }
        global.song_next = noone;
    }
}
