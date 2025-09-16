// Step Event

// Resetear velocidad


// Tecla de correr (X)
if (keyboard_check(ord("X"))) {
    velocidad_actual = 3.25;
	anim_speed = 0.1;
}
else{
	velocidad_actual = base_vel;
	anim_speed = 0.07;
}

// Detectar movimiento (WASD o flechas)
mx = (keyboard_check(vk_right) || keyboard_check(ord("D"))) - (keyboard_check(vk_left) || keyboard_check(ord("A")));
my = (keyboard_check(vk_down)  || keyboard_check(ord("S"))) - (keyboard_check(vk_up)   || keyboard_check(ord("W")));

// Si hay movimiento
if (mx != 0 || my != 0) {
    var dist = point_distance(0, 0, mx, my);
    x += (mx / dist) * velocidad_actual;
    y += (my / dist) * velocidad_actual;

    // --- Animación ---
    anim_timer += anim_speed;

    if (abs(mx) > abs(my)) {
        // Movimiento horizontal
        if (mx > 0) {
            // Derecha → frames 7-8
            image_index = 6 + floor(anim_timer) mod 2;
            last_dir = "right";
        } else {
            // Izquierda → frames 5-6
            image_index = 4 + floor(anim_timer) mod 2;
            last_dir = "left";
        }
    } else {
        // Movimiento vertical
        if (my > 0) {
            // Abajo → frames 1-4
            image_index = 0 + floor(anim_timer) mod 4;
            last_dir = "down";
        } else {
            // Arriba → frames 9-12
            image_index = 8 + floor(anim_timer) mod 4;
            last_dir = "up";
        }
    }
} else {
    // --- Idle (quieto) ---
    switch (last_dir) {
        case "down":  image_index = 0; break;   // primer frame abajo
        case "left":  image_index = 4; break;   // primer frame izquierda
        case "right": image_index = 6; break;   // primer frame derecha
        case "up":    image_index = 8; break;   // primer frame arriba
    }
    anim_timer = 0;
}