if (room == rm_gameOver_screen) {
    
    if (y >= bounce_y) {
        y = bounce_y;
        vspeed = -vspeed * 0.4; 
		bounces--
    }

    // no mor bounce
    if (vspeed < 0.01 && y >= bounce_y && bounces<=0) {
        vspeed = 0;
        gravity = 0;
        image_speed = 0; 
    }
}
