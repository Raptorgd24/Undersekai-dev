if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
    audio_play_sound(snd_menumove, 1, false);
    menu_index = (menu_index - 1 + array_length(menu_options)) mod array_length(menu_options);
}
if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
    audio_play_sound(snd_menumove, 1, false);
    menu_index = (menu_index + 1) mod array_length(menu_options);
}

switch (menu_options[menu_index]) {

    case "RESOLUTION":
        if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"))) {
            global.opt_resolution = min(global.opt_resolution + 1, 3);
            scr_options_apply();
            scr_options_save();
        }
        if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A"))) {
            global.opt_resolution = max(global.opt_resolution - 1, 0);
            scr_options_apply();
            scr_options_save();
        }
        break;

    case "FULLSCREEN":
        if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"))
        ||  keyboard_check_pressed(ord("Z"))  || keyboard_check_pressed(vk_enter)) {
            global.opt_fullscreen = !global.opt_fullscreen;
            scr_options_apply();
            scr_options_save();
        }
        break;

    case "MASTER VOL":
        if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"))) {
            global.opt_master_vol = min(round((global.opt_master_vol + 0.1) * 10) / 10, 1.0);
            scr_options_apply();
            scr_options_save();
        }
        if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A"))) {
            global.opt_master_vol = max(round((global.opt_master_vol - 0.1) * 10) / 10, 0.0);
            scr_options_apply();
            scr_options_save();
        }
        break;

    case "BACK":
        if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {
            audio_play_sound(snd_select, 1, false);
            if (room == rm_options) {
                audio_stop_sound(mus_options);
                room_goto(rm_ActualMenu);
            } else {
                instance_destroy();
            }
        }
        break;
}

if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift)) {
    audio_play_sound(snd_menumove, 1, false);
    if (room == rm_options) {
        audio_stop_sound(mus_options);
        room_goto(rm_ActualMenu);
    } else {
        instance_destroy();
    }
}