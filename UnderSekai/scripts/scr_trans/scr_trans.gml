function scr_trans(_the_room, _speed) {
    if (!global.trans_active) {
        global.trans_active = true;
		obj_player.can_move = false;
        global.trans_alpha = 0;
        global.trans_state = 0;
        global.trans_target = _the_room;
        if (argument_count > 1) global.trans_speed = _speed;
    }
}
