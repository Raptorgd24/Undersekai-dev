function scr_musictrans(new_song){

var _new_song  = argument0;

if (!variable_global_exists("song_volume")) global.song_volume = 1; // volumen actual
if (!variable_global_exists("song_target")) global.song_target = 1;
if (!variable_global_exists("song_speed"))  global.song_speed  = 0;

// --- si ya hay una canción sonando ---
if (audio_is_playing(global.song)) {
    global.song_target = 0;                        // volumen objetivo → fade out
    global.song_speed  = 1 / max(1, 0.1);   // velocidad del fade
    global.song_next   = _new_song;                // guardamos la siguiente
} else {
    // si no hay nada sonando, lanzamos directo
    global.song = audio_play_sound(_new_song, 1, true);
    audio_sound_gain(global.song, 0, 0);           // empieza en silencio
    global.song_target = 1;                        // volumen objetivo → fade in
    global.song_speed  = 1 / max(1, 0.1);
}
}