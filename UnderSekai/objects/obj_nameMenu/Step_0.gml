//step

// ARRIBA
if (menu_state == MenuState.INPUT) {
if (keyboard_check_pressed(vk_up)) {
    row = max(0, row - 1);
    col = min(col, array_length(keyboard[row]) - 1);
}

// ABAJO
if (keyboard_check_pressed(vk_down)) {
    row = min(array_length(keyboard) - 1, row + 1);
    col = min(col, array_length(keyboard[row]) - 1);
}

// IZQUIERDA
if (keyboard_check_pressed(vk_left)) {
    col = max(0, col - 1);
}

// DERECHA
if (keyboard_check_pressed(vk_right)) {
    col = min(array_length(keyboard[row]) - 1, col + 1);
}

if (keyboard_check_pressed(ord("Z"))) {

    var key = keyboard[row][col];

if (key == "ENTER") {
    if (string_length(text_input) > 0) {
        menu_state = MenuState.CONFIRM;
        event_user(0); // evento "Are you sure?"
    }
}

    else if (key == "RETURN") {
        if (string_length(text_input) > 0) {
            text_input = string_delete(
                text_input,
                string_length(text_input),
                1
            );
        }
    }
    else {
        if (string_length(text_input) < max_chars) {
            text_input += key;
        }
    }
}

}

if (menu_state == MenuState.CONFIRM) {

    // tween simple del nombre
    name_scale = lerp(name_scale, 2, 0.1);

    // mover selección Sí / No
    if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_right)) {
        confirm_option = 1 - confirm_option;
    }

    if (keyboard_check_pressed(ord("Z"))) {

        if (confirm_option == 0) {
            // SÍ
            show_debug_message("Nombre confirmado: " + text_input);
            // aquí luego metes tu animación
        }
        else {
            // NO → volver a escribir
            menu_state = MenuState.INPUT;
            name_scale = 1;
        }
    }
}
