function scr_events(_event) {
    switch (_event) {

        case 1:
            show_debug_message("[scr_events] arrancando evento 1");

            // Bloquear movimiento del jugador
            obj_player.can_move = false;
            obj_usable.can_use = false;

            // Mostrar diálogos iniciales
            scr_dialogue("sans", 10, "don't make another step kid...", true);
            scr_dialogue("sans", 7, "this time i'm serious", true);
            scr_dialogue("sans", 4, "so serious I could eat a horse", false);

            // Buscar NPC con npc_id == "sans"
            global.event_npc = noone;
            with (obj_NPC_parent) {
                if (variable_instance_exists(id, "npc_id") && npc_id == "sans") {
                    global.event_npc = id;
                }
            }

            if (global.event_npc != noone) {
                show_debug_message("[scr_events] NPC encontrado: " + string(global.event_npc.npc_id));
                
                // Programar inicio del evento después de los diálogos
                global.event_datalol = [
                    ["after_dialogue", function() {
                        show_debug_message("[scr_events] Iniciando caminata del NPC");
                                    obj_player.can_move = false;
									obj_usable.can_use = false;
                        if (instance_exists(global.event_npc)) {
                            scr_npcwalk(global.event_npc, "left", 180, 1, false);
                            global.waiting_for_walk = true;
                        }
                    }]
                ];
                global.event_step = 0;
                global.event_time = -1;
            } else {
                show_debug_message("[scr_events] No se encontró NPC con npc_id=sans");
                obj_player.can_move = true;
                obj_usable.can_use = true;
            }
        break;
    }
}