/// @desc Control del menú de batalla

// --- Movimiento del cursor ---
if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"))) {
    audio_play_sound(snd_menumove, 1, false);
    seleccion = (seleccion + 1) mod 4;
}

if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A"))) {
    audio_play_sound(snd_menumove, 1, false);
    seleccion = (seleccion + 3) mod 4;
}

// --- Confirmar opción ---
if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"))) {
    audio_play_sound(snd_select, 1, false);
    var opcion = opciones[seleccion];
    show_debug_message("Seleccion: " + opcion);

    switch (opcion) {
        case "FIGHT": with (obj_fight) { execute_action(); } break;
        case "ACT":   with (obj_act)   { execute_action(); } break;
        case "ITEM":  with (obj_item)  { execute_action(); } break;
        case "MERCY": with (obj_mercy) { execute_action(); } break;
    }
}

// --- Actualizar posiciones y frames de los botones ---
var base_x = boton_x_inicial;
var base_y = boton_y;

var objs = [obj_fight, obj_act, obj_item, obj_mercy];
for (var i = 0; i < 4; i++) {
    var xx = base_x + i * boton_espaciado;
    var yy = base_y;

    with (objs[i]) {
        image_index = (i == other.seleccion) ? 1 : 0;
    }
}

// --- Actualizar corazón ---
if (instance_exists(obj_heart)) {
    var selected_obj = objs[seleccion];

    if (instance_exists(selected_obj)) {
        with (obj_heart) {
            x = selected_obj.x+4 ; // posición del corazón (izquierda del botón)
            y = selected_obj.y+6;  // ajustar verticalmente si lo ves necesario


        }
    }
}
