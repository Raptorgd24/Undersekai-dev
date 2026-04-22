function scr_trans(_the_room=rm_Room666, _x=0, _y=0) {

	show_debug_message("Que transaaa")
	if (instance_exists(obj_heart))
	instance_destroy(obj_heart)
    if (!global.trans_active) {
        global.trans_active = true;
        obj_player.can_move = false;
        obj_usable.can_use = false;
		obj_control._x =_x;
		obj_control._y =_y;
        global.trans_alpha = 0;
        global.trans_state = 0;
        global.trans_target = _the_room;
		
        // --- Determinar zona de la habitación ---
        var room_zone = get_zone_for_room(_the_room);

        // Solo cambiar música si la zona es diferente
        if (!is_undefined(room_zone) && room_zone != global.current_zone) {
            var new_song = noone;
            if (ds_map_exists(global.zone_music, room_zone)) {
                new_song = ds_map_find_value(global.zone_music, room_zone);
            }

            if (!is_undefined(new_song) && new_song != noone) {
                scr_musictrans(new_song, 30); // fade de 30 frames
            }

            global.current_zone = room_zone;
        }
    }
}