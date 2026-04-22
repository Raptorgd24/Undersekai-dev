// obj_slash - Step
/// Comportamiento visual; al terminar animación, aplicamos la animación de golpe al enemigo real

// Usamos final de animación de modo robusto:
if (global.enemy !="Sans"){
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
			                            if (!variable_instance_exists(id, "hurt_sound_played")) hurt_sound_played = false;
                            hurt_sound_played = false;
                        }
                    }
                }
            }
        }
    
	scr_screenshake(10,2)
    // Destruir el slash (efecto terminado)
    instance_destroy();
}

}else{
if (image_index == image_number - 1) {
	
instance_destroy();

}
}