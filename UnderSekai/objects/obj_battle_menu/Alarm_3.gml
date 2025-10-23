// obj_battle_menu - Alarm[3] -> Fin del turno enemigo (vuelta al jugador)
show_debug_message("obj_battle_menu - Alarm[3] -> fin turno enemigo, vuelve jugador");
mode = "menu";
turn = "player";

// Restaurar texto del menú

    with (obj_thebox) {
        text = other.text_to_show;
        display_text = "";
        text_index = 0;
    }


// Restaurar corazón al menú principal

    with (obj_heart) {
        mode = "select";
        x = other.boton_x_inicial + other.seleccion * other.boton_espaciado + 4;
        y = other.boton_y + 6;
    }
