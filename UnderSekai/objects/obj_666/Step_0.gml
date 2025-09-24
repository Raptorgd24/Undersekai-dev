// STEP EVENT
// Ajustar depth dinámico
if (obj_player.y < y) {
    depth = obj_player.depth - 1;
} else {
    depth = obj_player.depth + 1;
}

// Input para activar
if ((keyboard_check_pressed(ord("Z")) && obj_usable.can_use && shitassbool) 
|| (keyboard_check_pressed(vk_enter) && obj_usable.can_use && shitassbool)) {
    if (place_meeting(x, y, obj_usable)) {
        alarm_set(0, 1);
    }
}

// Reducir el slowvalue hasta 0
if (slowvalue > 0 && shitassbool=false) {
    slowvalue -= 0.03;
    if (slowvalue < 0) slowvalue = 0; // clamp para no ir en negativo
}

// Asignar alpha
image_alpha = slowvalue;

// Si el alpha ya es 0, destruir instancia
if (image_alpha <= 0) {
    instance_destroy();
}
