audio_stop_sound(songbattle);
mode = "end";

with (obj_heart) {
    x = other.box_x - 423;
    y = other.box_y - 115;
}

if (is_tutorial) {
    with (obj_thebox) {
        text         = "* Tutorial completado.";
        display_text = "";
        text_index   = 0;
    }
} else {
    if (!was_spared) {
        global.xp   += expgiven;
        global.gold += goldGiven;
        global.kills += 1;
        scr_lvlup_game();
        with (obj_thebox) {
            text         = "Battle won, earnt " + string(other.expgiven) + "EXP and " + string(other.goldGiven) + "G";
            display_text = "";
            text_index   = 0;
        }
    } else {
        global.gold += goldGiven;
        with (obj_thebox) {
            text         = "Battle won, earnt 0EXP and " + string(other.goldGiven) + "G";
            display_text = "";
            text_index   = 0;
        }
    }

    if (global.enemy_id != "") {
        scr_set_global_data(global.enemy_id, true);
    }
}