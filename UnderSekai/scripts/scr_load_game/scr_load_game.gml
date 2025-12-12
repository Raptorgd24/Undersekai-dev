function scr_load_game() {

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
    global.healthu    = real(file_text_read_string(file)); file_text_readln(file);
    global.maxHP    = real(file_text_read_string(file)); file_text_readln(file);
    global.gold      = real(file_text_read_string(file)); file_text_readln(file);
    global.objects   = file_text_read_string(file); file_text_readln(file);
    global.weapon    = file_text_read_string(file); file_text_readln(file);
    global.armor     = file_text_read_string(file); file_text_readln(file);
    global.play_time = real(file_text_read_string(file)); file_text_readln(file);
	global.events_done = file_text_read_string(file); file_text_readln(file);
	global.xp      = real(file_text_read_string(file)); file_text_readln(file);
	show_debug_message(global.events_done);
	
	// Limpia y convierte los arrays desde texto
// --- OBJECTS ---
global.objects = string_replace_all(global.objects, "[", "");
global.objects = string_replace_all(global.objects, "]", "");
global.objects = string_replace_all(global.objects, "\"", ""); // quitar comillas
global.objects = string_replace_all(global.objects, " ", "");

if (string_length(global.objects) == 0) {
    global.objects = [];
} else {
    global.objects = string_split(global.objects, ",");
}



// --- EVENTS_DONE ---
global.events_done = string_replace_all(global.events_done, "[", "");
global.events_done = string_replace_all(global.events_done, "]", "");
global.events_done = string_replace_all(global.events_done, "\"", ""); // quitar comillas
global.events_done = string_replace_all(global.events_done, " ", "");

if (string_length(global.events_done) == 0) {
    global.events_done = [];
} else {
    global.events_done = string_split(global.events_done, ",");
}

show_debug_message(global.events_done);
    file_text_close(file);
	
    // === AÑADIDO: Establecer música correcta para la room guardada ===
    var target_room = asset_get_index(global.room_name);
    if (target_room != -1) {
        // Determinar zona de la room - con verificación de que las variables existen
        var _zone = "TestRooms"; // Por defecto
        
        // Verificar si las variables globales de zonas existen antes de usarlas
        if (variable_global_exists("zone_TestRooms") && array_length(global.zone_TestRooms) > 0) {
            for (var i = 0; i < array_length(global.zone_TestRooms); i++) {
                if (global.zone_TestRooms[i] == target_room) {
                    _zone = "TestRooms";
                    break;
                }
            }
        }
        
        if (variable_global_exists("zone_MysteryRooms") && array_length(global.zone_MysteryRooms) > 0) {
            for (var i = 0; i < array_length(global.zone_MysteryRooms); i++) {
                if (global.zone_MysteryRooms[i] == target_room) {
                    _zone = "MysteryRooms";
                    break;
                }
            }
        }
        
        if (variable_global_exists("zone_Silence") && array_length(global.zone_Silence) > 0) {
            for (var i = 0; i < array_length(global.zone_Silence); i++) {
                if (global.zone_Silence[i] == target_room) {
                    _zone = "Silence";
                    break;
                }
            }
        }
        
        // Establecer la música correcta solo si el mapa de música existe
        if (variable_global_exists("zone_music") && ds_map_exists(global.zone_music, _zone)) {
            global.song_asset = ds_map_find_value(global.zone_music, _zone);
            show_debug_message("🎵 [LOAD GAME] Música establecida: " + string(global.song_asset) + " para zona: " + _zone);
        } else {
            // Si no existe el sistema de música, usar una por defecto
            global.song_asset = mus_666;
            show_debug_message("🎵 [LOAD GAME] Usando música por defecto: " + string(global.song_asset));
        }
        
        // Hacer transición automática a la room guardada
        room_goto(target_room);

		
    } else {
        show_debug_message("⚠ scr_load_game: No se encontró la room '" + string(global.room_name) + "'");
    }

    show_debug_message("✅ scr_load_game: Archivo cargado correctamente");
	
	
	
}
