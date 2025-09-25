function scr_events(_event) {
    switch (_event) {

        case 1:
            show_debug_message("scr_events: arrancando evento 1");

            // Bloquear movimiento del jugador
            obj_player.can_move = false;

            // Mostrar diálogos
            scr_dialogue("sans", 10, "don't make another step kid...", true);
            scr_dialogue("sans", 7, "this time i'm serious", true);
            scr_dialogue("sans", 4, "so serious I could eat a horse", false);

            // --- DEBUG: listar todos los NPCs en la room ---
            with (obj_NPC_parent) {
                show_debug_message("NPC id=" + string(id) + " tiene npc_id=" + string(npc_id));
            }

            // Buscar NPC por npc_id y guardar instancia
            var npc_inst = noone;
            with (obj_NPC_parent) {
                if (npc_id == "sans") {
                    npc_inst = id;
                    break; // salir del with
                }
            }

            // Definir callback que se ejecutará al finalizar el diálogo
            global.dialogue_end_callback = function() {
                if (npc_inst != noone) {
                    scr_npc_walk_inst(npc_inst, "Right", 32, function(_npc) {
                        show_debug_message("NPC terminó de caminar!");
                        instance_create_layer(_npc.x, _npc.y, "Instances", obj_boom_temp);
                    });
                } else {
                    show_debug_message("⚠ No se encontró NPC con id 'sans'");
                }
            };

            // El resto del evento puede continuar usando alarm si quieres
            alarm[0] = room_speed * 5;

            // No devolver aún el control al jugador: lo hará el callback cuando termine el diálogo
        break;
    }
}
