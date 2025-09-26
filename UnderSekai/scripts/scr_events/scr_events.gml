function scr_events(_event) {
    switch (_event) {

        case 1:
            show_debug_message("[scr_events] arrancando evento 1");

            // Bloquear movimiento del jugador
            obj_player.can_move = false;

            // Mostrar diálogos
            scr_dialogue("sans", 10, "don't make another step kid...", true);
            scr_dialogue("sans", 7, "this time i'm serious", true);
            scr_dialogue("sans", 4, "so serious I could eat a horse", false);

            // Buscar NPC con npc_id == "sans"
            var npc = noone;
            with (obj_NPC_parent) {
                if (variable_instance_exists(id, "npc_id") && npc_id == "sans") {
                    npc = id;
                }
            }

            if (npc != noone) {
                var nid = variable_instance_exists(npc, "npc_id") ? variable_instance_get(npc, "npc_id") : "";
                show_debug_message("[scr_events] NPC encontrado con npc_id=" + string(nid) + ", iniciando caminata");

                // Llamamos al script pasando la instancia objetivo como primer argumento
                scr_npcwalk(npc, "left", 180, 1, false);
            }
            else {
                show_debug_message("[scr_events] No se encontró NPC con npc_id=sans");
            }

            // Continuar evento / desbloquear jugador
            alarm[0] = room_speed * 5; 
            obj_player.can_move = true;
        break;
    }
}
