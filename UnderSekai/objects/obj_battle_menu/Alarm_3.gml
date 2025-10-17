/// obj_battle_menu - Alarm[3]
show_debug_message("Alarm[3] activado: fin del turno enemigo, volvemos al menú");

mode = "menu";

if (instance_exists(obj_thebox)) {
    with (obj_thebox) {
        text = other.text_to_show;
        display_text = "";
        text_index = 0;
        show_debug_message("Texto del menú principal restaurado en obj_thebox");
    }
}

// Restaurar corazón al menú principal
if (instance_exists(obj_heart)) {
    with (obj_heart) {
        mode = "select";
        x = other.boton_x_inicial + other.seleccion * other.boton_espaciado + 4;
        y = other.boton_y + 6;
        show_debug_message("Corazón restaurado a la opción seleccionada del menú");
    }
}
