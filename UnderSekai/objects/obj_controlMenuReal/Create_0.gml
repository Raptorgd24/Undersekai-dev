/// @description Inserte aquí la descripción
// Puede escribir su código en este editor

image_alpha = 0; // El objeto empieza invisible
// Fuente
// === CONFIGURACIÓN DE MENÚ ===
audio_play_sound(mus_close, 1, true);

// Fuente
font_menu = ft_determinationsans;

// Verificar si existe el archivo de guardado
has_save = file_exists("save.dat");

// Debug: estado del save
if (has_save) {
    show_debug_message("save.dat detectado");
    menu_options = ["CONTINUE", "RESET", "OPTIONS"];
} else {
    show_debug_message("No se detecta save.dat ");
    menu_options = ["START", "OPTIONS"];
}

// Índice actual
menu_index = 0;

// Posición base
menu_x = 16;
menu_spacing = 32;

show_debug_message("Opciones del menú: " + string(menu_options));
