if (active && place_meeting(x, y, obj_player)) {
	
    scr_hurt(2,2);

    var p = instance_place(x, y, obj_player);
    
    if (p != noone) {
        if (p.x < x) {
            p.x -= 4;
        } else if (p.x > x) {
            p.x += 4;
        }

        if (p.y < y) {
            p.y -= 4;
        } else if (p.y > y) {
            p.y += 4;
        }
    }
}