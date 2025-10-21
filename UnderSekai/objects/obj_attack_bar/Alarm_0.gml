// obj_attack_bar - Alarm[0]
/// Aplica daño al enemigo y actualiza texto / turnos

if (did_hit) {
   
    if (instance_exists(battle_id)) {
        with (battle_id) {
			 dmg = other.damage; // Guardamos daño local antes de entrar a with()
            // Restar vida del enemigo
            if (variable_instance_exists(id, "enemyHealth")) {
                enemyHealth -= dmg;
                enemyHealth = max(0, enemyHealth);

                // Mostrar texto del golpe
                if (instance_exists(obj_thebox)) {
                    with (obj_thebox) {
                        text = "* You hit " + other.enemyName + " for " + string(other.dmg) + "!";
                        display_text = "";
                        text_index = 0;
                    }
                }
            }

            // Avisar al enemigo para que reproduzca animación de daño
            if (instance_exists(theEnemy)) {
                with (theEnemy) {
                    is_hurt = true;
                    can_move = false;
                }
            }

            // Programar inicio del turno enemigo
            alarm[2] = 1;
        }
    } else {
        // Fallback: buscar el menú manualmente
        if (instance_exists(obj_battle_menu)) {
            with (instance_find(obj_battle_menu, 0)) {
                alarm[2] = 1;
            }
        }
    }
}

// Destruir la barra tras aplicar daño
instance_destroy();
