// obj_gameover - Step Event

// Si estamos en la room del game over
if (room == rm_gameOver_screen) {

    if (!once) {
        once = true;
        // Efecto de piezas del corazón roto
        for (var i = 0; i < 5; i++) {
            var lesize = random_range(0.5, 1);
            var piece = instance_create_layer(random_range(140, 170), 0, "Instances", obj_heart_piece);
            piece.direction = 270;
            piece.speed = random_range(0.001, 0.005);
            piece.gravity = 0.07;
            piece.gravity_direction = 270; 
            piece.image_xscale = lesize;
            piece.image_yscale = lesize;
            piece.bounce_y = random_range(180, 190);
            piece.bounces = random_range(1,3);
        }
    }

    // Aparición gradual de sprites
    spr_glow_alpha = min(spr_glow_alpha + 0.02, 1);
    spr_ble_alpha = min(spr_ble_alpha + 0.02, 1);

    // Entrada al menú (solo si no está en fade)
    if (!fading) {
        if (keyboard_check_pressed(vk_left)) {
            menu_index = max(0, menu_index - 1);
        }
        if (keyboard_check_pressed(vk_right)) {
            menu_index = min(array_length(menu_options) - 1, menu_index + 1);
        }

        if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"))) {
            // Iniciar fundido
            fading = true;
            fade_action = (menu_index == 0) ? "continue" : "giveup";
        }
    }

    // Manejo del fundido
    if (fading) {
        fade_alpha = min(fade_alpha + fade_speed, 1);
        if (fade_alpha >= 1) {
            if (fade_action == "continue") {
				instance_destroy(obj_gameOver)
				instance_destroy(obj_control)
				instance_destroy(obj_cam)
				instance_destroy(obj_usable)
				instance_destroy(obj_player)
				audio_sound_gain(deathsong,0,100)
                scr_load_game();
            } else if (fade_action == "giveup") {
				audio_sound_gain(deathsong,0,100)
				
                game_restart();
            }
        }
    }
}
