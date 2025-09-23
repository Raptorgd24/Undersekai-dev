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
