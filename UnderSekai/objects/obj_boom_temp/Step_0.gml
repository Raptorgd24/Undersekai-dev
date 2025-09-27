// Step Event de obj_boom_temp - VERSIÓN PRECISA
var current_frame = floor(image_index);

// Destruir sans en el frame 7
if (current_frame == 7 && !variable_global_exists("sans_destroyed")) {
    show_debug_message("🔥 Frame " + string(current_frame) + ": Destruyendo NPC sans");
    
    // Método 1: Usar parent_npc
    if (variable_instance_exists(id, "parent_npc") && instance_exists(parent_npc)) {
        instance_destroy(parent_npc);
        global.sans_destroyed = true;
    } 
    // Método 2: Backup - buscar sans cercano
    else {
        var sans_found = noone;
        with (obj_NPC_parent) {
            if (npc_id == "sans" && point_distance(x, y, other.x + 20, other.y + 20) < 100) {
                sans_found = id;
            }
        }
        
        if (instance_exists(sans_found)) {
            instance_destroy(sans_found);
            global.sans_destroyed = true;
        }
    }
}

// Destruir explosión al final
if (current_frame >= image_number - 1) {
    // Limpiar la variable global
    if (variable_global_exists("sans_destroyed")) {
        global.sans_destroyed = undefined;
    }
    instance_destroy();
}