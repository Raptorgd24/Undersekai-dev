//step
// Ajuste de depth solo si no es passable
if (!passable) {
    // El jugador está por encima o por debajo de mí
    if (obj_player.y < y) {
        depth = obj_player.depth - 1;
    } else {
        depth = obj_player.depth + 1;
    }
}
else{
depth = obj_player.depth + 1;
}

// Si se pulsa Z y el jugador puede usar cosas
if (keyboard_check_pressed(ord("Z")) && obj_usable.can_use || (keyboard_check_pressed(vk_enter)) && obj_usable.can_use) {
    if (place_meeting(x, y, obj_usable)) {
        if (!global.dialogue_active) {
            npc_dialogue();
        }
    }
}


    // --- Movimiento automático ---
    if (npc_state != "Idle" && npc_duration > 0) {
        switch(npc_state) {
            case "Down": my = 1; mx = 0; break;
            case "Up":   my = -1; mx = 0; break;
            case "Left": mx = -1; my = 0; break;
            case "Right":mx = 1; my = 0; break;
        }
        var dist = point_distance(0, 0, mx, my);
        var dx = (mx / dist) * base_vel;
        var dy = (my / dist) * base_vel;

        // Movimiento con colisión simple (puedes cambiar obj_colision)
        if (!place_meeting(x + dx, y, obj_colision)) x += dx;
        if (!place_meeting(x, y + dy, obj_colision)) y += dy;

        npc_timer += 1;

        // Animación
        anim_timer += anim_speed;
        if (abs(mx) > abs(my)) {
            if (mx > 0) { image_index = 6 + floor(anim_timer) mod 2; last_dir = "right"; }
            else { image_index = 4 + floor(anim_timer) mod 2; last_dir = "left"; }
        } else {
            if (my > 0) { image_index = 0 + floor(anim_timer) mod 4; last_dir = "down"; }
            else { image_index = 8 + floor(anim_timer) mod 4; last_dir = "up"; }
        }

        // Revisar si terminó
        if (npc_timer >= npc_duration) {
            npc_state = "Idle";
            npc_timer = 0;
            npc_duration = 0;
            anim_timer = 0;
            mx = 0; my = 0;

            // Poner frame idle
            switch(last_dir) {
                case "down":  image_index = 0; break;
                case "left":  image_index = 4; break;
                case "right": image_index = 6; break;
                case "up":    image_index = 8; break;
            }

            // Ejecutar callback si existe
            if (_inst.npc_next_action != noone) {
                _inst.npc_next_action();
                _inst.npc_next_action = noone;
            }
        }

    } else {
        // Idle: animación quieta
        anim_timer = 0;
        mx = 0; my = 0;
        switch(last_dir) {
            case "down":  image_index = 0; break;
            case "left":  image_index = 4; break;
            case "right": image_index = 6; break;
            case "up":    image_index = 8; break;
        }
    }
