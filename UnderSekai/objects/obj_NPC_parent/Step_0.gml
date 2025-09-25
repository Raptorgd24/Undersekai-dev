/// --------------------- STEP EVENT obj_NPC_parent ---------------------

// Ajuste de depth según passable
if (!passable) {
    depth = (obj_player.y < y) ? obj_player.depth - 1 : obj_player.depth + 1;
} else {
    depth = obj_player.depth + 1;
}

// Interacción con usable
if ((keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) && obj_usable.can_use) {
    if (place_meeting(x, y, obj_usable)) {
        if (!global.dialogue_active) {
            npc_dialogue();
        }
    }
}

// --- Movimiento automático ---
if (npc_state != "Idle" && npc_duration > 0) {

    // Dirección
    switch(npc_state) {
        case "Down":  my = 1; mx = 0; break;
        case "Up":    my = -1; mx = 0; break;
        case "Left":  mx = -1; my = 0; break;
        case "Right": mx = 1; my = 0; break;
    }

    // Normalizar movimiento
    var dist = point_distance(0, 0, mx, my);
    var dx = (mx / dist) * base_vel;
    var dy = (my / dist) * base_vel;

    // Movimiento con colisión simple
    if (!place_meeting(x + dx, y, obj_colision)) x += dx;
    if (!place_meeting(x, y + dy, obj_colision)) y += dy;

    npc_timer += 1;

    // Animación
    anim_timer += anim_speed;
    if (abs(mx) > abs(my)) {
        // Horizontal
        if (mx > 0) { image_index = 9 + floor(anim_timer) mod 4; last_dir = "right"; }
        else        { image_index = 5 + floor(anim_timer) mod 4; last_dir = "left"; }
    } else {
        // Vertical
        if (my > 0) { image_index = 0 + floor(anim_timer) mod 5; last_dir = "down"; }
        else if (my < 0) { image_index = 13 + floor(anim_timer) mod 4; last_dir = "up"; }
    }

    // Fin de movimiento
    if (npc_timer >= npc_duration) {
        npc_state = "Idle";
        npc_timer = 0;
        npc_duration = 0;
        anim_timer = 0;
        mx = 0; my = 0;

        // Idle frame
        switch(last_dir) {
            case "down":  image_index = 0; break;
            case "left":  image_index = 5; break;
            case "right": image_index = 9; break;
            case "up":    image_index = 13; break;
        }


    }

} else {
    // Idle
    anim_timer = 0;
    mx = 0; my = 0;
    switch(last_dir) {
        case "down":  image_index = 0; break;
        case "left":  image_index = 5; break;
        case "right": image_index = 9; break;
        case "up":    image_index = 13; break;
    }
}
