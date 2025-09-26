// Ajuste de depth solo si no es passable
if (!passable) {
    if (obj_player.y < y) {
        depth = obj_player.depth - 1;
    } else {
        depth = obj_player.depth + 1;
    }
}
else {
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

// --- Movimiento del NPC ---
if (NPCmoving) {
    var mx = 0;
    var my = 0;
    var spd = NPCspeed;
    if (NPCmoonwalk) spd = -spd;

    switch (NPCdirection) {
        case "down":  my = spd; break;
        case "up":    my = -spd; break;
        case "left":  mx = -spd; break;
        case "right": mx = spd; break;
    }

    // Aplicar movimiento
    x += mx;
    y += my;

    // --- Animación ---
    anim_timer += anim_speed;

    if (abs(mx) > abs(my)) {
        if (mx > 0) {
            image_index = 6 + floor(anim_timer) mod 2;
            last_dir = "right";
        } else {
            image_index = 4 + floor(anim_timer) mod 2;
            last_dir = "left";
        }
    } else {
        if (my > 0) {
            image_index = 0 + floor(anim_timer) mod 4;
            last_dir = "down";
        } else {
            image_index = 8 + floor(anim_timer) mod 4;
            last_dir = "up";
        }
    }

    NPCframes -= 1;
    show_debug_message("[obj_NPC_parent:Step] " + string(npc_id) + 
        " caminando hacia " + string(NPCdirection) + 
        " | frames restantes=" + string(NPCframes));

    if (NPCframes <= 0) {
        NPCmoving = false;
        show_debug_message("[obj_NPC_parent:Step] " + string(npc_id) + " terminó de caminar.");
    }
}
else {
    // --- Idle ---
    switch (last_dir) {
        case "down":  image_index = 0; break;
        case "left":  image_index = 4; break;
        case "right": image_index = 6; break;
        case "up":    image_index = 8; break;
    }
    anim_timer = 0;
}
