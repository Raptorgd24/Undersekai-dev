function scr_load_game(){
	
/// scr_load_game()
/// Carga save.dat (incluye global.play_time)

function scr_load_game() {
    // Asegurar que todas las globales existen ANTES de leer
    if (!variable_global_exists("room_name")) global.room_name = "rm_Room1";
    if (!variable_global_exists("name")) global.name = "Frisk";
    if (!variable_global_exists("lv")) global.lv = 1;
    if (!variable_global_exists("health")) global.health = 20;
    if (!variable_global_exists("maxHP")) global.maxHP = 20;
    if (!variable_global_exists("gold")) global.gold = 0;
    if (!variable_global_exists("objects")) global.objects = "[]";
    if (!variable_global_exists("weapon")) global.weapon = "Stick";
    if (!variable_global_exists("armor")) global.armor = "Bandage";
    if (!variable_global_exists("play_time")) global.play_time = 0;

    // Si no hay save, salir
    if (!file_exists("save.dat")) {
        show_debug_message("scr_load_game: save.dat no existe ❌");
        return;
    }

    // Leer el archivo
    var file = file_text_open_read("save.dat");

    global.room_name = file_text_read_string(file); file_text_readln(file);
    global.name      = file_text_read_string(file); file_text_readln(file);
    global.lv        = real(file_text_read_string(file)); file_text_readln(file);
    global.health    = real(file_text_read_string(file)); file_text_readln(file);
    global.maxHP    = real(file_text_read_string(file)); file_text_readln(file);
    global.gold      = real(file_text_read_string(file)); file_text_readln(file);
    global.objects   = file_text_read_string(file); file_text_readln(file);
    global.weapon    = file_text_read_string(file); file_text_readln(file);
    global.armor     = file_text_read_string(file); file_text_readln(file);
    global.play_time = real(file_text_read_string(file)); file_text_readln(file);
    file_text_close(file);


    // Hacer transición automática a la room guardada
    var target_room = asset_get_index(global.room_name);
    if (target_room != -1) {
        room_goto(target_room);
    } else {
        show_debug_message("⚠ scr_load_game: No se encontró la room '" + string(global.room_name) + "'");
    }

    show_debug_message("✅ scr_load_game: Archivo cargado correctamente");
}

}