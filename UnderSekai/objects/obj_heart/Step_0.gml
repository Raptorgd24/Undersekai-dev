switch (mode) {
    case "select":
        gui_x = target_x
        gui_y = target_y
        break;

    case "battle":
        var dx = keyboard_check(vk_right) - keyboard_check(vk_left);
        var dy = keyboard_check(vk_down)  - keyboard_check(vk_up);
        var tspeed = 4;

        x = clamp(x + dx * tspeed, box_left, box_right);
        y = clamp(y + dy * tspeed, box_top, box_bottom);

        gui_x = x;
        gui_y = y;
        break;
}
