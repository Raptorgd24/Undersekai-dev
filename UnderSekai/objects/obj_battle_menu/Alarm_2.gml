/// obj_battle_menu - Alarm[2]
show_debug_message("Alarm[2] activado: inicio del turno enemigo (texto)");

if (instance_exists(obj_thebox)) {
    with (obj_thebox) {
        text = "* The enemy is preparing an attack.";
        display_text = "";
        text_index = 0;
        show_debug_message("Texto del turno enemigo mostrado en obj_thebox");
    }
}

// Programamos el fin del turno enemigo en Alarm[3] tras 2 segundos
alarm[3] = room_speed * 2; 
show_debug_message("Alarm[3] configurado para finalizar turno enemigo en 2 segundos");
