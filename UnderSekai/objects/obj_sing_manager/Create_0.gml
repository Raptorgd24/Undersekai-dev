battle_id     = noone;
song_instance = -1;
song_position = 0;
song_duration = 30000;
chart_start_offset = 500;

combo        = 0;
max_combo    = 0;
total_score  = 0;
fame_given   = 0;
notes_hit    = 0;
notes_missed = 0;

timing_sick = 45;
timing_good = 90;
timing_bad  = 150;

show_combo    = true;
chart_active  = false;
chart_end_time = 0;

notes = ds_list_create();

pressed_keys = {
    D: false,
    F: false,
    J: false,
    K: false
};

depth = -500;