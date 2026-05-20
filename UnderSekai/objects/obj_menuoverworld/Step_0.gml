if (input_lock > 0) {
    input_lock--;
    exit;
}

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var current_size = sizes[$ state];
box_w = current_size.w;
box_h = current_size.h;
box_x = (gui_w - box_w) / 2;
box_target_y = gui_h - box_h - 16;

tween_timer += delta_time / 1000000;
var t = clamp(tween_timer / tween_duration, 0, 1);
var ease = 1 - power(1 - t, 3);

if (!is_closing) {
    box_y = lerp(gui_h, box_target_y, ease);
    if (t >= 1) is_open = true;
} else {
    box_y = lerp(box_target_y, gui_h, ease);
    if (t >= 1) {
        if (close_releases_player) {
            obj_player.can_move = true;
            obj_usable.can_use = true;
        }
        instance_destroy();
        exit;
    }
}

if (!is_open) exit;

if (state == "main") {
    if (keyboard_check_pressed(vk_shift) || keyboard_check_pressed(ord("X")) || keyboard_check_pressed(ord("C"))) {
        tween_timer = 0;
        is_closing = true;
        is_open = false;
        exit;
    }

    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
        audio_play_sound(snd_menumove, 1, false);
        main_index = (main_index - 1 + array_length(main_options)) mod array_length(main_options);
    }
    if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
        audio_play_sound(snd_menumove, 1, false);
        main_index = (main_index + 1) mod array_length(main_options);
    }
    if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {
        audio_play_sound(snd_select, 1, false);
        switch (main_options[main_index]) {
            case "Items":
                state = "items";
                item_index = 0;
                tween_timer = 0;
                break;
				
			case "Options":
				audio_play_sound(snd_select, 1, false);
				state = "options";
				options_index = 0;
				tween_timer  = 0;
				break;
        }
    }
}

else if (state == "items") {
    if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift)) {
        audio_play_sound(snd_menumove, 1, false);
        state = "main";
        tween_timer = 0;
        exit;
    }

    if (keyboard_check_pressed(ord("C"))) {
        tween_timer = 0;
        is_closing = true;
        is_open = false;
        exit;
    }

    var item_count = array_length(items);
    if (item_count > 0) {
        if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
            audio_play_sound(snd_menumove, 1, false);
            item_index = (item_index - 1 + item_count) mod item_count;
        }
        if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
            audio_play_sound(snd_menumove, 1, false);
            item_index = (item_index + 1) mod item_count;
        }

        if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {
            audio_play_sound(snd_select, 1, false);
            var current_item = items[item_index];
			var data = scr_item_data(current_item);
            var result = scr_useitem(current_item);

            if (result.used) {
                array_delete(global.objects, item_index, 1);
                items = global.objects;
                item_index = clamp(item_index, 0, max(0, array_length(items) - 1));
            }
			if (data.type == "weapon" || data.type == "armor") {
				array_delete(global.objects, item_index, 1);
				items = global.objects;
				item_index = clamp(item_index, 0, max(0, array_length(items) - 1));
			}
			close_releases_player = false;
            tween_timer = 0;
            is_closing = true;
            is_open = false;

            var dialogue_struct = {
                messages: [
                    {
                        text: result.text,
                        character: "",
                        face_index: 0,
                        keep_box: false
                    }
                ],
                release_move: true
            };
            dialogue_start(dialogue_struct);
        }
    }
}
else if (state == "options") {
	
    if (options_confirm) {
		if (keyboard_check_pressed(ord("C"))) {
			tween_timer = 0;
			is_closing = true;
			is_open = false;
			exit;
		}
        if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A"))
        ||  keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"))) {
            audio_play_sound(snd_menumove, 1, false);
            options_index = (options_index == 0) ? 1 : 0;
        }

        if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {
            if (options_index == 0) {
                scr_options_save();
                game_end();
            } else {
                audio_play_sound(snd_menumove, 1, false);
                options_confirm = false;
                options_index   = array_length(options_list) - 1;
            }
        }

        if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift)) {
            audio_play_sound(snd_menumove, 1, false);
            options_confirm = false;
            options_index   = array_length(options_list) - 1;
        }

        exit;
    }

    if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift)) {
        audio_play_sound(snd_menumove, 1, false);
        state = "main";
        tween_timer = 0;
        exit;
    }
	    if (keyboard_check_pressed(ord("C"))) {
        tween_timer = 0;
        is_closing = true;
        is_open = false;
        exit;
    }
    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
        audio_play_sound(snd_menumove, 1, false);
        options_index = (options_index - 1 + array_length(options_list)) mod array_length(options_list);
    }
    if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
        audio_play_sound(snd_menumove, 1, false);
        options_index = (options_index + 1) mod array_length(options_list);
    }

    switch (options_list[options_index]) {

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

        case "EXIT GAME":
            if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {
                audio_play_sound(snd_select, 1, false);
                options_confirm = true;
                options_index   = 1;
            }
            break;
    }
}