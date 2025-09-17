// El jugador está por encima o por debajo de mí
if (obj_player.y <y) {
    // Jugador más abajo → jugador delante
    depth = obj_player.depth - 1;
} else {
    // Jugador más arriba → NPC delante
    depth = obj_player.depth + 1;
}

// Si se pulsa Z y el jugador puede usar cosas
if (keyboard_check_pressed(ord("Z")) && obj_usable.can_use) {
    // Comprobar colisión con el jugador
    if (place_meeting(x, y, obj_usable)) {
        // 🔹 Aquí llamamos al diálogo
        // De momento un ejemplo fijo, pero se puede sobrescribir en cada hijo
        dialogue("sans", 1, "TU MADRE LA GORDA", true);
    }
}
