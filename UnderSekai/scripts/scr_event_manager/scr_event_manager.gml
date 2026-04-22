// scr_event_manager.gml
// Sistema mejorado de eventos

global.event_manager = {
    active: false,
    current_event: undefined,
    step: 0,
    time: -1,
    waiting_for_dialogue: false,
    waiting_for_walk: false,
    waiting_for_boom: false,
    npc: noone,
    boom_frames: 0
};

function event_start(_event_struct) {
    if (global.event_manager.active) return false;
    
    global.event_manager.current_event = _event_struct;
    global.event_manager.step = 0;
    global.event_manager.time = -1;
    global.event_manager.active = true;
    
    event_next();
    return true;
}

function event_next() {
    if (!global.event_manager.active) return;
    
    var mgr = global.event_manager;
    var event = mgr.current_event;
    
    if (mgr.step >= array_length(event.steps)) {
        event_end();
        return;
    }
    
    var step = event.steps[mgr.step];
    mgr.step++;
    
    // Ejecutar acción del step
    if (variable_struct_exists(step, "action")) {
        step.action();
    }
}

function event_end() {
    var mgr = global.event_manager;
    mgr.active = false;
    mgr.current_event = undefined;
    mgr.step = 0;
    mgr.time = -1;
    mgr.waiting_for_dialogue = false;
    mgr.waiting_for_walk = false;
    mgr.waiting_for_boom = false;
    mgr.npc = noone;
    mgr.boom_frames = 0;
}

function event_update() {
    var mgr = global.event_manager;
    if (!mgr.active) return;
    
    var event = mgr.current_event;
    var step = event.steps[mgr.step - 1];
    
    // Esperar diálogo
    if (mgr.waiting_for_dialogue) {
        if (!global.dialogue_manager.active && (!variable_global_exists("dialogue_use_timer") || global.dialogue_use_timer <= 0)) {
            mgr.waiting_for_dialogue = false;
            event_next();
        }
        return;
    }
    
    // Esperar caminar
    if (mgr.waiting_for_walk) {
        if (instance_exists(mgr.npc) && !mgr.npc.NPCmoving) {
            mgr.waiting_for_walk = false;
            event_next();
        }
        return;
    }
    
    // Esperar boom
    if (mgr.waiting_for_boom) {
        if (mgr.boom_frames > 0) {
            mgr.boom_frames--;
        } else {
            mgr.waiting_for_boom = false;
            event_next();
        }
        return;
    }
    
    // Timer
    if (variable_struct_exists(step, "wait_frames")) {
        mgr.time++;
        if (mgr.time >= step.wait_frames) {
            mgr.time = -1;
            event_next();
        }
    }
}
