// obj_slash - Step
/// Comportamiento visual; al terminar animación, aplicamos la animación de golpe al enemigo real

// Usamos final de animación de modo robusto:
if (image_index == image_number - 1) {

        // Fallback robusto: intentar acceder al menú global
        if (variable_global_exists("battle_menu") && instance_exists(global.battle_menu)) {
            with (global.battle_menu) {
                if (instance_exists(theEnemy)) {
                    with (theEnemy) {
                        if (!is_hurt) {
                            is_hurt = true;
                            can_move = false;
                            //image_index = 14;
                            //image_speed = 0.3;
							show_debug_message("Tu madre la gorda")
                            if (!variable_instance_exists(id, "hurt_sound_played")) hurt_sound_played = false;
                            hurt_sound_played = false;
                        }
                    }
                }
            }
        }
    

    // Destruir el slash (efecto terminado)
    instance_destroy();
}
