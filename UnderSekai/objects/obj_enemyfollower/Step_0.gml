// ── PATRULLA ──────────────────────────────────────────────
if (!followPlayer && !detected) {

    if (is_waiting) {
        // Esperando: contar frames hasta reanudar movimiento
        wait_timer--;
        if (wait_timer <= 0) {
            is_waiting = false;
            move_timer = irandom_range(90, 200);
        }

    } else {
        // Moviéndose: comprobar colisión ANTES de mover
        if (place_meeting(x + hsp * dir, y, obj_colision)) {
            // Pared → invertir dirección y esperar
            dir       *= -1;
            is_waiting = true;
            wait_timer = irandom_range(45, 120);
        } else {
            x += hsp * dir;
        }

        // Timer de movimiento agotado → esperar y cambiar dirección
        move_timer--;
        if (move_timer <= 0) {
            dir       *= -1;
            is_waiting = true;
            wait_timer = irandom_range(60, 150);
        }
    }
}

// ── DETECCIÓN ─────────────────────────────────────────────
if (!detected && canCollide) {
    if (instance_exists(obj_player)) {
        var dist = point_distance(x, y, obj_player.x, obj_player.y);

        if (dist < detect_range) {
            detected      = true;
            current_speed = 0;
            show_alert    = true;
            audio_play_sound(alert_sound, 1, false);
            alarm[0] = room_speed * 0.7;
        }
    }
}

// ── PERSECUCIÓN ───────────────────────────────────────────
if (followPlayer && instance_exists(obj_player) && !place_meeting(x, y, obj_player)) {

    var dir_to_player = point_direction(x, y, obj_player.x, obj_player.y);

    if (current_speed < le_speed) {
        current_speed += 0.2;
    }

    var vx = lengthdir_x(current_speed, dir_to_player);
    var vy = lengthdir_y(current_speed, dir_to_player);

    // Colisión con obj_colision también en persecución
    if (!place_meeting(x + vx, y, obj_colision)) x += vx;
    if (!place_meeting(x, y + vy, obj_colision)) y += vy;
}

// ── COLISIÓN CON JUGADOR → BATALLA ────────────────────────
if (canCollide && place_meeting(x, y, obj_player)) {
    canCollide    = false;
    current_speed = 0;
    detected      = false;
    scr_start_battle(whoAreYou, enemy_unique_id); // ✅ pasa el ID
}