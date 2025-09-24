function scr_musictrans(_new_song) {

    if (!variable_global_exists("song_volume")) global.song_volume = 1;
    if (!variable_global_exists("song_target")) global.song_target = 1;
    if (!variable_global_exists("song_speed"))  global.song_speed  = 60; // fijo

    // Si hay canción sonando
    if (audio_is_playing(global.song)) {
        global.song_target = 0;      // fade out
        global.song_speed  = 60;     // fija
        global.song_next   = _new_song;
    } else {
        // Si no hay canción, iniciamos directamente
        global.song = audio_play_sound(_new_song, 1, true);
        audio_sound_gain(global.song, 0, 0);
        global.song_target = 1;      // fade in
        global.song_speed  = 60;     // fija
        global.song_next   = noone;
    }
}
