// CONTROL INPUT
if (input_delay > 0) {
    input_delay--;
    input_enabled = false;
} else {
    input_enabled = true;
}

if (confirm_lock_timer > 0) {
    confirm_lock_timer--;
}


// =====================
// INPUT (ESCRIBIR NOMBRE)
// =====================
if (menu_state == MenuState.INPUT) {

    if (keyboard_check_pressed(vk_up)) {
        audio_play_sound(snd_menumove, 1, false);
        row = max(0, row - 1);
        col = min(col, array_length(keyboard[row]) - 1);
    }

    if (keyboard_check_pressed(vk_down)) {
        audio_play_sound(snd_menumove, 1, false);
        row = min(array_length(keyboard) - 1, row + 1);
        col = min(col, array_length(keyboard[row]) - 1);
    }

    if (keyboard_check_pressed(vk_left)) {
        audio_play_sound(snd_menumove, 1, false);
        col = max(0, col - 1);
    }

    if (keyboard_check_pressed(vk_right)) {
        audio_play_sound(snd_menumove, 1, false);
        col = min(array_length(keyboard[row]) - 1, col + 1);
    }

    // ACEPTAR (Z o ENTER)
    if (input_enabled && confirm_lock_timer <= 0 &&
        (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter))) {

        audio_play_sound(snd_select, 1, false);
        confirm_lock_timer = 10;

        var key = keyboard[row][col];

        if (key == "ENTER") {
            if (string_length(text_input) > 0) {
                menu_state = MenuState.CONFIRM;
                confirm_option = 0;
                input_delay = 10;

                if (!instance_exists(obj_textName)) {
                    instance_create_layer(0, 0, "Instances", obj_textName);
                }

                with (text_obj) {
                    target_scale = 2;
                }
            }
        }
        else if (key == "RETURN") {
            if (string_length(text_input) > 0) {
                text_input = string_delete(text_input, string_length(text_input), 1);
            }
        }
        else {
            if (string_length(text_input) < max_chars) {
                text_input += key;

                with (text_obj) {
                    key_pop = 1.3;
                }
            }
        }
    }

    // BORRAR (X o SHIFT)
    if (input_enabled && confirm_lock_timer <= 0 &&
        (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift))) {

        confirm_lock_timer = 10;

        if (string_length(text_input) > 0) {
            text_input = string_delete(text_input, string_length(text_input), 1);
        }
    }
}


// =====================
// CONFIRM
// =====================
if (menu_state == MenuState.CONFIRM) {

    if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_right)) {
        confirm_option = 1 - confirm_option;

        with (text_obj) {
            key_pop = 1.1;
        }
    }

    // ACEPTAR
    if (input_enabled && confirm_lock_timer <= 0 &&
        (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter))) {

        confirm_lock_timer = 20;

        if (confirm_option == 0) {

            if (instance_exists(obj_textName)) {
                with (obj_textName) instance_destroy();
            }

            audio_stop_sound(mus_close);

            global.name = text_input;
            scr_save_game();

            fading = true;
            fade_timer = 0;
            fade_done = false;

            input_enabled = false;
            input_delay = 35;
        }
		else{
		        confirm_lock_timer = 15;

        if (instance_exists(obj_textName)) {
            with (obj_textName) instance_destroy();
        }

        menu_state = MenuState.BACK_ANIM;
        input_delay = 10;

        with (text_obj) {
            target_scale = 1;
        }
		}
    }

    // VOLVER
    if (input_enabled && confirm_lock_timer <= 0 &&
        (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift))) {

        confirm_lock_timer = 15;

        if (instance_exists(obj_textName)) {
            with (obj_textName) instance_destroy();
        }

        menu_state = MenuState.BACK_ANIM;
        input_delay = 10;

        with (text_obj) {
            target_scale = 1;
        }
    }
}

// teehee
if (text_input ="GASTER"){
game_restart()
}

// =====================
// BACK ANIM
// =====================
if (menu_state == MenuState.BACK_ANIM) {

	if (abs(text_obj.name_scale - 1) < 0.05) {
		text_obj.name_scale = 1;
		menu_state = MenuState.INPUT;
	}
}


// =====================
// FADE
// =====================
if (fading) {

    fade_timer++;

    fade_alpha = fade_timer / fade_duration;

    if (fade_alpha >= 1 && !fade_done) {
        fade_alpha = 1;
        fade_done = true;
		if (text_input ="GOSE" ||text_input ="GOOSE")|| text_input ="JOSE"{
			room_goto(rm_Shucks)
		} else{
			scr_init_zones();
			scr_load_game();
		}
    }
}