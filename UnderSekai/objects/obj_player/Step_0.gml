// Step Event
if (can_move){
// Tecla de correr (X)
if (keyboard_check(ord("X")) || keyboard_check(vk_shift)) {
    velocidad_actual = 3.25;
    anim_speed = 0.1;
}
else {
    velocidad_actual = base_vel;
    anim_speed = 0.07;
}
if (keyboard_check_pressed(ord("V"))) {
	scr_trans(rm_StartingPointBeta);
}

if (keyboard_check_pressed(ord("B"))) {
	scr_start_battle("Roaring_Fraud");
}
// Detectar movimiento (WASD o flechas)
mx = (keyboard_check(vk_right) || keyboard_check(ord("D"))) - (keyboard_check(vk_left) || keyboard_check(ord("A")));
my = (keyboard_check(vk_down)  || keyboard_check(ord("S"))) - (keyboard_check(vk_up)   || keyboard_check(ord("W")));

// Si hay movimiento
if (mx != 0 || my != 0) {
    var dist = point_distance(0, 0, mx, my);
    var dx = (mx / dist) * velocidad_actual;
    var dy = (my / dist) * velocidad_actual;

// --- Movimiento con colisión ---
var inst_x = instance_place(x + dx, y, obj_NPC_parent);
var inst_y = instance_place(x, y + dy, obj_NPC_parent);

// Comprobación X
if ((!inst_x || inst_x.passable) && !place_meeting(x + dx, y, obj_colision) && !place_meeting(x + dx, y, obj_save)) {
    x += dx;
}

// Comprobación Y
if ((!inst_y || inst_y.passable) && !place_meeting(x, y + dy, obj_colision) && !place_meeting(x, y + dy, obj_save)) {
    y += dy;
}



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
} else {
    // --- Idle ---
    switch (last_dir) {
        case "down":  image_index = 0; break;
        case "left":  image_index = 4; break;
        case "right": image_index = 6; break;
        case "up":    image_index = 8; break;
    }
    anim_timer = 0;
}
}