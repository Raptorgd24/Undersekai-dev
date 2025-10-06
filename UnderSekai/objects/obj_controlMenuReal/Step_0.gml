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
if (keyboard_check_pressed(vk_f4)) {
    if (!window_get_fullscreen()) {
        window_set_fullscreen(true);
    } else {
        window_set_fullscreen(false);
    }
}
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
            var file = file_text_open_write("save.dat");
            file_text_close(file);
            show_debug_message("Archivo save.dat creado correctamente ✅");
            room_goto(rm_Room1);
        break;
        
        case "CONTINUE":
            show_debug_message("Continuando juego...");
            room_goto(rm_Room1);
        break;
        
        case "RESET":
            show_debug_message("Eliminando save.dat...");
            if (file_exists("save.dat")) file_delete("save.dat");
            show_debug_message("save.dat eliminado. Creando nuevo...");
            var file = file_text_open_write("save.dat");
            file_text_close(file);
            show_debug_message("Nuevo save.dat creado ✅");
            room_goto(rm_Room1);
        break;
        
        case "OPTIONS":
            show_debug_message("Abriendo menú de opciones...");
            room_goto(rm_options);
        break;
    }
}
