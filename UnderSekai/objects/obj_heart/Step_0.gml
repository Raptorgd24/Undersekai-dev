if (mode == "select") {
    // En este modo, el corazón puede moverse suavemente hacia la opción seleccionada
    // Pero solo cuando haya una selección de menú activa
    // El menú (obj_battle_menu) controlará el target_x, target_y para el corazón

    x = lerp(x, target_x, 0.2);
    y = lerp(y, target_y, 0.2);

} else if (mode == "battle") {
    // Modo de esquivar: el jugador mueve el corazón libremente dentro del “battle box”
    var dx = keyboard_check(vk_right) - keyboard_check(vk_left);
    var dy = keyboard_check(vk_down)  - keyboard_check(vk_up);
    var tspeed = 4;

    x += dx * tspeed;
    y += dy * tspeed;

    // Limitar dentro del rectángulo del box
    if (x < box_left) x = box_left;
    if (x > box_right) x = box_right;
    if (y < box_top) y = box_top;
    if (y > box_bottom) y = box_bottom;
}
