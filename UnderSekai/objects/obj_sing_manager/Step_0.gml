// obj_sing_manager - Step

if (!chart_active) return;

// -- 1. Validar instancia de audio -------------------------------------------
if (song_instance < 0 || !audio_exists(song_instance)) {
    show_debug_message("[sing_manager] song_instance invalido. Abortando chart.");
    chart_active = false;
    return;
}

if (!audio_is_playing(song_instance)) {
    show_debug_message("[sing_manager] Audio detenido. Finalizando.");
    chart_active = false;
    return;
}

// -- 2. Actualizar posicion manualmente con delta_time -----------------------
// delta_time esta en MICROSEGUNDOS en GML, dividir entre 1000 da milisegundos.
// No usamos audio_get_play_position porque no existe en todos los runtimes.
song_position += delta_time / 1000;

// -- 3. Input del jugador ----------------------------------------------------
if (keyboard_check_pressed(ord("D"))) scr_sing_note_hit(id, "D");
if (keyboard_check_pressed(ord("F"))) scr_sing_note_hit(id, "F");
if (keyboard_check_pressed(ord("J"))) scr_sing_note_hit(id, "J");
if (keyboard_check_pressed(ord("K"))) scr_sing_note_hit(id, "K");

// -- 4. Actualizar notas y comprobar missed ----------------------------------
scr_sing_update(id);
scr_sing_check_missed(id);
