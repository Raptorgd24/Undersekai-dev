if (!chart_active) return;

if (song_instance < 0 || !audio_exists(song_instance)) {
    chart_active = false;
    return;
}

if (!audio_is_playing(song_instance)) {
    chart_active = false;
    return;
}

song_position += delta_time / 1000;

if (keyboard_check_pressed(ord("D"))) scr_sing_note_hit(id, "D");
if (keyboard_check_pressed(ord("F"))) scr_sing_note_hit(id, "F");
if (keyboard_check_pressed(ord("J"))) scr_sing_note_hit(id, "J");
if (keyboard_check_pressed(ord("K"))) scr_sing_note_hit(id, "K");

scr_sing_update(id);
scr_sing_check_missed(id);