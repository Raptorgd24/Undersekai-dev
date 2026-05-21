battle_id     = noone;
song_instance = -1;
song_position = 0;
song_duration = 30000;
chart_start_offset = 900;

combo        = 0;
max_combo    = 0;
total_score  = 0;
fame_given   = 0;
notes_hit    = 0;
notes_missed = 0;
total_notes  = 0;
acc_points   = 0;

timing_perfect = 45;
timing_great   = 90;
timing_good    = 140;
timing_bad     = 180;

show_combo     = true;
chart_active   = false;
chart_finished = false;
chart_end_time = 0;
finish_timer   = 0;

performance = 65;
last_judge   = "";
judge_timer  = 0;
last_lane    = "";

notes = ds_list_create();

key_lanes = ["D", "F", "J", "K"];
key_codes = [ord("D"), ord("F"), ord("J"), ord("K")];
lane_flash = [0, 0, 0, 0];
mobile_last = [false, false, false, false];

depth = -500;
