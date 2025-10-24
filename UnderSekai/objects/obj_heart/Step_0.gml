// --- Comportamiento según modo


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
        var dx = keyboard_check(vk_right) - keyboard_check(vk_left);
        var dy = keyboard_check(vk_down)  - keyboard_check(vk_up);
         
        //if (variable_instance_exists(id, "box_left")) {
            x = clamp(x + dx*soulspeed, box_left+2, box_right-12);
            y = clamp(y + dy*soulspeed, box_top+2, box_bottom-12);
        /*} else {
            x += dx*soulspeed;
            y += dy*soulspeed;
        }*/
		
        break;
}

// --- Cooldown manual

// --- Reducir cooldown cada step (por si algún otro objeto la llama)
if (global.atkcooldown) {
    global.cooldowntimer -= 1;
    

    // Hace que parpadee cada 5 frames (ajusta a tu gusto)
    if ((global.cooldowntimer div 10) mod 2 == 0) {
        image_alpha = 0.5;
    } else {
        image_alpha = 1;
    }

    // Cuando se acaba el cooldown, se restablece
    if (global.cooldowntimer <= 0) {
        global.atkcooldown = false;
        image_alpha = 1;
    }
}


// --- Debug / curación rápida
if (keyboard_check_pressed(ord("V"))){
    scr_heal(20);
}
