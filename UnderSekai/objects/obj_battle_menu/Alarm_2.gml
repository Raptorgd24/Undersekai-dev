// obj_battle_menu - Alarm[2] -> Inicio del turno enemigo (texto / animación)
/// Iniciamos la secuencia de turno enemigo (texto corto)
show_debug_message("obj_battle_menu - Alarm[2] -> inicio turno enemigo (texto)");
mode = "enemy_turn";
turn = "enemy";
obj_heart.mode = "enemy_turn"
obj_heart.x = 154
obj_heart.y =145
// Mostrar texto del turno enemigo
if (instance_exists(obj_thebox)) {
with (obj_thebox) {
    // Cambiamos el tamaño a algo más cuadrado
	show_debug_message("hola soy repo y soy un buen amigo");

	target_width = 80;
	target_height = 80;
	target_x = 120
	target_y = 108
}
}

// programamos fin del turno enemigo en alarm[3] (2 segundos por defecto)
alarm[3] = room_speed * turntime;
