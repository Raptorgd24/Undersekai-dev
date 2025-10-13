if (keyboard_check_pressed(vk_right)|| keyboard_check_pressed(ord("D"))) {
    seleccion = (seleccion + 1) mod 4;
}
if (keyboard_check_pressed(vk_left)|| keyboard_check_pressed(ord("A"))) {
    seleccion = (seleccion + 3) mod 4;
}
if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"))) {
    show_debug_message("Seleccion: " + string(opciones[seleccion]));
    // Aquí podrías decidir moverte a modo batalla, o manejar la acción seleccionada
    // Por ejemplo:
    // with (obj_heart) mode = "battle";
}

// Actualizar la posición objetivo del corazón
with (obj_heart) {
    target_x = other.box_x + other.heart_offset_x[other.seleccion];
    target_y = other.box_y - 40;  // por encima del cuadro del menú, ajustar como quieras
}
