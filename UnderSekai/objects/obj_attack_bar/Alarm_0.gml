// obj_attack_bar - Alarm[0]
/// Aplica daño al enemigo y actualiza texto / turnos

if (did_hit) {
   
    if (instance_exists(battle_id)) {
        with (battle_id) {
			var dead = false;
			 dmg = other.damage; // Guardamos daño local antes de entrar a with()
            // Restar vida del enemigo
            if (variable_instance_exists(id, "enemyHealth")) {
                enemyHealth -= dmg;
                enemyHealth = max(0, enemyHealth);
				if (enemyHealth <= 0){
				dead=true 
				}

            }

            // Avisar al enemigo para que reproduzca animación de daño
                with (theEnemy) {
                    is_hurt = true;
                    can_move = false;
                }
            

            // Programar inicio del turno enemigo
			
			if (!dead){
            alarm[5] = room_speed*0.75;
			}
			else{
			alarm[4] = room_speed*0.75;
			}
        }
    }
} else{
	with (battle_id) {
		alarm[4] = room_speed*0.75;
	}
	
	
}

// Destruir la barra tras aplicar daño
instance_destroy();
