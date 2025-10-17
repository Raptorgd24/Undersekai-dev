/// obj_attack_bar - Alarm[0]
show_debug_message("obj_attack_bar - Alarm[0] triggered (aplicar daño)");

if (did_hit) {
    show_debug_message("did_hit = true, aplicando daño: " + string(damage));
    if (variable_instance_exists(id, "battle_id") && instance_exists(battle_id)) {
        with (battle_id) {
            // Aplicar daño al enemigo (si tienes enemyName/health variables)
            if (variable_instance_exists(id, "enemyHealth")) {
                // si tu menu gestiona enemyHealth:
                enemyHealth -= other.damage; // NOTA: other dentro del with será obj_attack_bar
            }

            // Mostrar texto de daño en obj_thebox

            // Iniciar turno enemigo usando Alarm[2] (texto) -> Alarm[3] (fin)
            show_debug_message("Asignando Alarm[2] para inicio del turno enemigo");
            alarm[2] = 1;
        }
    } else {
        show_debug_message("battle_id no existe en Alarm[0], fallback: mostrando texto genérico");

        // igualmente iniciamos Alarm[2] buscando obj_battle_menu
        if (instance_exists(obj_battle_menu)) {
            with (instance_find(obj_battle_menu, 0)) {
                alarm[2] = 1;
            }
        }
    }
}

// destruir la barra al final del proceso
instance_destroy();
show_debug_message("obj_attack_bar destruido desde Alarm[0]");
