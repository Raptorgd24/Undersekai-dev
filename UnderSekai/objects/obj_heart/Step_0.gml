switch(mode){
    case "select":
        gui_x = target_x;
        gui_y = target_y;
        break;
    case "enemy_select":
        gui_x = x;
        gui_y = y;
        break;
    case "enemy_turn":
	if (mode != "dead"){
        var dx = (keyboard_check(vk_right) || keyboard_check(ord("D"))) - (keyboard_check(vk_left) || keyboard_check(ord("A")));
        var dy = (keyboard_check(vk_down)  || keyboard_check(ord("S"))) - (keyboard_check(vk_up)   || keyboard_check(ord("W")));
                 
            x = clamp(x + dx*soulspeed, box_left+2, box_right-12);
            y = clamp(y + dy*soulspeed, box_top+2, box_bottom-12);
	}
        break;
	
}


// cooldown mierda
if (global.atkcooldown) {
    global.cooldowntimer -= 1;
    

   
    if ((global.cooldowntimer div 10) mod 2 == 0) {
        image_alpha = 0.5;
    } else {
        image_alpha = 1;
    }

    if (global.cooldowntimer <= 0) {
        global.atkcooldown = false;
        image_alpha = 1;
    }
}


if (keyboard_check_pressed(ord("V"))){
    scr_heal(20);
}
if (!dead){
	if (global.healthu <=0){
		dead = true;
		scr_die()
	}
}