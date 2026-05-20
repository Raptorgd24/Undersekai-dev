// === MOVIMIENTO DEL MENÚ ===
var moved = false;

if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
    menu_index -= 1;
    moved = true;
}
if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
    menu_index += 1;
    moved = true;
}
// Toggle pantalla completa con F4
/*if (keyboard_check_pressed(vk_f4)) {
    if (!window_get_fullscreen()) {
        window_set_fullscreen(true);
    } else {
        window_set_fullscreen(false);
    }
}*/

if (menu_index < 0) menu_index = 0;
if (menu_index > array_length(menu_options) - 1) menu_index = array_length(menu_options) - 1;

if (moved) {
    audio_play_sound(snd_menumove, 1, false);
    show_debug_message("Selección actual: " + string(menu_options[menu_index]) + " (índice " + string(menu_index) + ")");
}

if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"))) {
    var option = menu_options[menu_index];
    show_debug_message("Opción seleccionada: " + option);
    audio_play_sound(snd_select, 1, false);
    
switch (option) {
    case "START":
        show_debug_message("Creando nuevo save.dat...");
		
		scr_firststart()
    break;
    
	case "CONTINUE":
		audio_stop_sound(mus_close)
		show_debug_message("Cargando partida...");
		scr_init_zones();
		scr_load_game(); 
	break;
    
    case "RESET":
        show_debug_message("Reseteando save.dat...");
		
		scr_firststart()
    break;
    
    case "OPTIONS":
        show_debug_message("Abriendo menú de opciones...");
		audio_stop_sound(mus_close)
        room_goto(rm_options);
    break;
}

}
