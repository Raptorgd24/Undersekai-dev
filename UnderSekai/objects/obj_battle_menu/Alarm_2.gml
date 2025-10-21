// obj_battle_menu - Alarm[2] -> Inicio del turno enemigo (texto / animación)
/// Iniciamos la secuencia de turno enemigo (texto corto)
show_debug_message("obj_battle_menu - Alarm[2] -> inicio turno enemigo (texto)");
mode = "enemy_turn";
turn = "enemy";

// Mostrar texto del turno enemigo
if (instance_exists(obj_thebox)) {
    with (obj_thebox) {
        text = "* The enemy is preparing an attack.";
        display_text = "";
        text_index = 0;
    }
}

// programamos fin del turno enemigo en alarm[3] (2 segundos por defecto)
alarm[3] = room_speed * 2;
