function scr_npc_setmove(_inst, _dir, _frames){
/// _inst: instancia del NPC
/// _dir: "Up", "Down", "Left", "Right"
/// _frames: cantidad de frames que se moverá


// Inicializar variables si no existen
if (!variable_instance_exists(_inst, "npc_state")) {
    // Inicializar fallback
    _inst.npc_state    = "Idle";
    _inst.npc_speed    = 2;
    _inst.npc_timer    = 0;
    _inst.npc_duration = 0;
    _inst.npc_anim_timer = 0;
    _inst.last_dir = "Down";
}

_inst.npc_state    = _dir;
_inst.npc_duration = _frames;
_inst.npc_timer    = 0;
_inst.npc_anim_timer = 0;
_inst.last_dir = _dir;
}