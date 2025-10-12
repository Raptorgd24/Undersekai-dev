// --- Crear instancias necesarias si no existen ---
var save = instance_find(obj_save, 0);
if (!instance_exists(obj_player)) {
    
    if (save != noone) {
        instance_create_layer(save.x, save.y+2, "Instances", obj_player);
    }
}


if (!instance_exists(obj_usable)) {
    instance_create_layer(save.x, save.y, "Instances", obj_usable);
}

if (!instance_exists(obj_cam)) {
    instance_create_layer(save.x, save.y+10, "Instances", obj_cam);
}

if (!instance_exists(obj_control)) {
    instance_create_layer(0, 0, "Instances", obj_control);
}

/* --- Determinar zona actual según el room ---
// (Código inline similar a scr_get_zone_for_room)
var _zone = undefined;

if (array_length(global.zone_TestRooms) > 0) {
    for (var i = 0; i < array_length(global.zone_TestRooms); i++) {
        if (global.zone_TestRooms[i] == room) {
            _zone = "TestRooms";
            break;
        }
    }
}
if (is_undefined(_zone) && array_length(global.zone_MysteryRooms) > 0) {
    for (var i = 0; i < array_length(global.zone_MysteryRooms); i++) {
        if (global.zone_MysteryRooms[i] == room) {
            _zone = "MysteryRooms";
            break;
        }
    }
}
if (is_undefined(_zone) && array_length(global.zone_Silence) > 0) {
    for (var i = 0; i < array_length(global.zone_Silence); i++) {
        if (global.zone_Silence[i] == room) {
            _zone = "Silence";
            break;
        }
    }
}

// Si no se encontró zona, usar TestRooms por defecto
if (is_undefined(_zone)) _zone = "TestRooms";

// --- Aplicar zona y comunicar la música a obj_control ---
global.current_zone = _zone;

// Obtener la música asociada a la zona
if (ds_map_exists(global.zone_music, global.current_zone)) {
    var _mus = ds_map_find_value(global.zone_music, global.current_zone);

    // Buscar obj_control y pasarle la solicitud
    var _ctrl = instance_find(obj_control, 0);
    if (_ctrl != noone) {
        with (_ctrl) {
            global.song_asset = _mus;
        }
        show_debug_message("🎵 Zona detectada: " + string(global.current_zone) + " → solicitado cambio de música a: " + string(_mus));
    } else {
        // Fallback si no hay obj_control (raro)
       
        show_debug_message("⚠ No se encontró obj_control, se setea global.song_next = " + string(_mus));
    }

} else {
    show_debug_message("⚠ No se encontró música para la zona: " + string(global.current_zone));
}
