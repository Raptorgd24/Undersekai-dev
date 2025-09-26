function scr_events(_event) {
    switch (_event) {

        case 1:
            show_debug_message("scr_events: arrancando evento 1");

            // Bloquear movimiento del jugador
            obj_player.can_move = false;

            // Mostrar primer diálogo
            scr_dialogue("sans", 10, "don't make another step kid...", true);
            scr_dialogue("sans", 7, "this time i'm serious", true);
            scr_dialogue("sans", 4, "so serious I could eat a horse", false);

            // Seleccionar instancia concreta de NPC (la primera que encuentre)
			var npc = instance_find(obj_NPC_parent, 0);
			if (npc != noone) {
			    scr_npc_walk_inst(npc, "Right", 32, function() {
			        show_debug_message("NPC terminó de caminar!");
			        // Aquí puedes poner explosión, diálogo, etc
			        instance_create_layer(npc.x, npc.y, "Instances", obj_boom_temp);
			    });
			}
            // Configurar alarm para continuar el resto del evento si quieres
            alarm[0] = room_speed * 5; 
			obj_player.can_move = true;
        break;
    }
}
