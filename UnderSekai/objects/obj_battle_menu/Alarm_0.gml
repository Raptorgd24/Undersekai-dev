// obj_battle_menu - Alarm[0]
show_debug_message("Turno enemigo...");
text_to_show = "* The enemy is preparing an attack.";
with (obj_thebox) {
    text = other.text_to_show;
    display_text = "";
    text_index = 0;
}

// Simulación del turno enemigo (de momento nada)
alarm[1] = room_speed * 2; // después de 2 segundos vuelve el turno del jugador
