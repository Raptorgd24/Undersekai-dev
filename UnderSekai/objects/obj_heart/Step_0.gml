// obj_heart - Step
// Comportamientos según modo
switch (mode) {
    case "select":
        gui_x = target_x;
        gui_y = target_y;
        break;

    case "enemy_select":
        // Heart posicionado por obj_battle_menu durante selección de enemigo
        gui_x = x;
        gui_y = y;
        break;

    case "battle":
    case "fight_select":
        // Control libre en la zona de la caja (si quieres permitir mover el corazón en batalla)
        var dx = keyboard_check(vk_right) - keyboard_check(vk_left);
        var dy = keyboard_check(vk_down)  - keyboard_check(vk_up);
        var tspeed = 4;
        // clamp a rectángulo si existen límites (puede ser pasado por el menú si quieres)
        if (variable_instance_exists(id, "box_left")) {
            x = clamp(x + dx * tspeed, box_left, box_right);
            y = clamp(y + dy * tspeed, box_top, box_bottom);
        } else {
            x += dx * tspeed;
            y += dy * tspeed;
        }
        gui_x = x;
        gui_y = y;
        break;
}

// Input de depuración / curación rápida (mantener o quitar)
if (keyboard_check_pressed(ord("V"))) {
    // Si tienes un script scr_heal, lo llamamos; si no, lo comentas
    scr_heal(20);
}
