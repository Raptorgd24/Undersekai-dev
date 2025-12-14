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
// Capping (no circular)
if (menu_index < 0) menu_index = 0;
if (menu_index > array_length(menu_options) - 1) menu_index = array_length(menu_options) - 1;

// Si se movió, reproducir sonido y mostrar debug
if (moved) {
    audio_play_sound(snd_menumove, 1, false);
    show_debug_message("Selección actual: " + string(menu_options[menu_index]) + " (índice " + string(menu_index) + ")");
}

// === CONFIRMACIÓN DE SELECCIÓN ===
if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"))) {
    var option = menu_options[menu_index];
    show_debug_message("Opción seleccionada: " + option);
    audio_play_sound(snd_select, 1, false);
    
switch (option) {
    case "START":
        show_debug_message("Creando nuevo save.dat...");
        
        // Valores iniciales
        global.room_name = "rm_Room1";
        global.name = "EMPTY";
        global.lv = 1;
        global.healthu = 20;
        global.maxHP = 20;
        global.gold = 0;
        global.objects = ["FoodTest","FoodTest","FoodTest","FoodTest","FoodTest","FoodTest","FoodTest","FoodTest","FoodTest"];
        global.weapon = "Stick";
        global.armor = "Bandage";
        global.play_time = 0
		global.events_done = [];
		global.xp = 0;
        scr_save_game(); // guarda los valores iniciales
		if (!variable_global_exists("song_asset")) {
		    global.song_asset = mus_silence; // o el valor inicial que corresponda
		}
        room_goto(rm_Room1);
    break;
    
case "CONTINUE":
    show_debug_message("Cargando partida...");
	scr_init_zones();
    scr_load_game(); // esto ya hace el room_goto automáticamente
break;


    
    case "RESET":
        show_debug_message("Reseteando save.dat...");
        if (file_exists("save.dat")) file_delete("save.dat");

        // Restablecer a valores iniciales
        global.room_name = "rm_Room1";
        global.name = "EMPTY";
        global.lv = 1;
        global.healthu = 20;
        global.maxHP = 20;
        global.gold = 0;
        global.objects = ["ArmorTest","WeaponTest","FoodTest","KeyTest","FoodTest","FoodTest","FoodTest","FoodTest","FoodTest","FoodTest"];
        global.weapon = "Stick";
        global.armor = "Bandage";
        global.play_time = 0
		global.events_done = [];
		global.xp = 0
        scr_save_game();
		if (!variable_global_exists("song_asset")) {
		    global.song_asset = mus_silence; // o el valor inicial que corresponda
		}
        room_goto(rm_Room1);
    break;
    
    case "OPTIONS":
        show_debug_message("Abriendo menú de opciones...");
        room_goto(rm_options);
    break;
}

}
