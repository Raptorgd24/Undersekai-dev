function scr_npc_walk_inst(_inst, _dir, _pixels, _callback){
/// _inst: instancia del NPC
/// _dir: "Up", "Down", "Left", "Right"
/// _pixels: distancia en píxeles a recorrer
/// _callback: opcional, función a ejecutar al terminar

if (!variable_instance_exists(_inst, "npc_state")) {
    show_debug_message("⚠ NPC no inicializado correctamente.");
    return;
}

// Guardamos dirección
_inst.npc_state = _dir;
_inst.npc_timer = 0;
_inst.npc_duration = ceil(_pixels / _inst.base_vel); // calculamos en frames
_inst.npc_next_action = _callback;
_inst.can_move = false; // bloqueamos control manual si es necesario
}