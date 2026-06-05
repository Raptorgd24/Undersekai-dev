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

        // MOVIL: tocar una opcion la selecciona y confirma
        if (is_mobile() && tap_pressed()) {
            var _gw = display_get_gui_width();
            var _cx = _gw / 2;
            var _by = display_get_gui_height() * 0.7;
            for (var ti = 0; ti < array_length(menu_options); ti++) {
                var _xh = _cx + ((ti - 0.5) * 200);
                if (tap_in(_xh - 20, _by - 10, _xh + 180, _by + 40)) {
                    menu_index  = ti;
                    fading      = true;
                    fade_action = (ti == 0) ? "continue" : "giveup";
                }
            }
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
				audio_sound_gain(deathsong,0,100)
                game_restart();
            } else if (fade_action == "giveup") {
				
				audio_sound_gain(deathsong,0,100)
                game_end();
            }
        }
    }
}
