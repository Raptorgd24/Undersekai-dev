/// @description Fin del turno enemigo (vuelta al jugador)
show_debug_message("obj_battle_menu - Alarm[3] -> fin turno enemigo, vuelve jugador");
mode = "menu";
turn = "player";
instance_destroy(bullets)
instance_destroy(bullet)
// Restaurar texto del menú

    with (obj_thebox) {
        text = other.text_to_show;
        display_text = "";
        text_index = 0;
		target_width = 280;
		target_height = 78;
		target_x = 25;
		target_y = 110;
    }


// Restaurar corazón al menú principal

    with (obj_heart) {
        mode = "select";
        x = other.boton_x_inicial + other.seleccion * other.boton_espaciado + 4;
        y = other.boton_y + 6;
    }
