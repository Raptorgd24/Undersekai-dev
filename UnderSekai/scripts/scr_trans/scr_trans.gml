function scr_trans(_the_room = rm_Room666, _x = 0, _y = 0) {
    if (!global.trans_active) {
        global.trans_active  = true;
        global.trans_target  = _the_room;
        global.trans_state   = 0;
        global.trans_alpha   = 0;

        obj_control._x = _x;
        obj_control._y = _y;

        if (instance_exists(obj_player)) {
            obj_player.can_move = false;
        }
        if (instance_exists(obj_usable)) {
            obj_usable.can_use = false;
        }
        if (instance_exists(obj_heart)) {
            instance_destroy(obj_heart);
        }

        var room_zone = get_zone_for_room(_the_room);
        if (!is_undefined(room_zone) && room_zone != global.current_zone) {
            var new_song = noone;
            if (ds_map_exists(global.zone_music, room_zone)) {
                new_song = ds_map_find_value(global.zone_music, room_zone);
            }
            if (!is_undefined(new_song) && new_song != noone) {
                scr_musictrans(new_song, 30);
            }
            global.current_zone = room_zone;
        }
    }
}