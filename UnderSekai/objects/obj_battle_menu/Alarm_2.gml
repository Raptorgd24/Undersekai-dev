/// @description  Inicio del turno enemigo (texto / animación)
/// Iniciamos la secuencia de turno enemigo (texto corto)
show_debug_message("obj_battle_menu - Alarm[2] -> inicio turno enemigo (texto)");
// Limpiar texto anterior
if (instance_exists(obj_thebox)) with (obj_thebox) {
    text = "";
    display_text = "";
    text_index = 0;
}
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
	target_y = 109
}
}

switch (attack_name){
	case "knifeda":
		show_debug_message("knifu da!")
		turntime= 10;
		bullet = obj_mknife;
		bullets = noone;
		//bulletcooldown = 50;
		//bulletcooldownOG = bulletcooldown;
		bullet_x = 30;
		bullet_x2 = 300;
		bullet_y = 30;
		bullet_y2 = 200;
	break;
}

	
// programamos fin del turno enemigo en alarm[3] (turntime segundos)
alarm[3] = room_speed * turntime;
