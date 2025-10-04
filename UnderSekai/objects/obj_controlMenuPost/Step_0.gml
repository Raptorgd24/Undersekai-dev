/// @description Contar los timers frame a frame

// Restar timers si son mayores a 0
if (lil_timer > 0) lil_timer--;
if (other_timer > 0) other_timer--;

// Mostrar en consola (opcional)
show_debug_message("lil_timer: " + string(lil_timer));
show_debug_message("other_timer: " + string(other_timer));

// Si presiona Z o Enter y lil_timer ya terminó
if ((keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) && lil_timer == 0) {
    show_debug_message("SKIP ACTIVADO - skipping to room");
    room_goto_next();
}

// Si el otro timer llegó a 0
if (other_timer == 0) {
    room_goto_next();
}
