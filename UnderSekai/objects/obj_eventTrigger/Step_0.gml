// STEP - trigger eventos solo una vez mientras el jugador esté sobre el trigger
if (randomassbool == true) {
    if (place_meeting(x, y, obj_player)) {
				var npc = instance_create_layer(487, 164, "Instances", obj_NPC_parent);
		npc.npc_id = "sans";
        scr_events(1);

        // Evitar retriggers inmediatos: desactivar hasta que expire la alarma
        randomassbool = false;
		show_debug_message("Trigger disparado en instancia " + string(id));
		obj_player.can_move = false;
        // scr_events ya configura alarm[0] = room_speed * 5; si quieres controlarlo aquí, descomenta la línea siguiente:
        // alarm[0] = room_speed * 5;
    }
}
