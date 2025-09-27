/// scr_npc_walk_inst(_npc, _direction, _frames)
function scr_npc_walk_inst(_npc, _direction, _frames) {
    if (instance_exists(_npc)) {
        scr_npcwalk(_npc, _direction, _frames, 1, false);
    }
}