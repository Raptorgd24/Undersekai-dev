// Destroy Event de obj_boom_temp

// Destruir NPC asociado si existe la referencia parent_npc
if (variable_instance_exists(id, "parent_npc")) {
    if (instance_exists(parent_npc)) {
        show_debug_message("[obj_boom_temp] Destruyendo NPC asociado: " + string(parent_npc));
        instance_destroy(parent_npc);
    } else {
        show_debug_message("[obj_boom_temp] parent_npc existe pero la instancia no");
    }
} else {
    show_debug_message("[obj_boom_temp] No existe variable parent_npc en esta explosión");
}

// También destruir cualquier NPC en la misma posición (por si acaso)
with (obj_NPC_parent) {
    if (point_distance(x, y, other.x + 20, other.y + 20) < 50) { // Radio de 50 píxeles
        show_debug_message("[obj_boom_temp] Destruyendo NPC cercano: " + string(npc_id));
        instance_destroy();
    }
}