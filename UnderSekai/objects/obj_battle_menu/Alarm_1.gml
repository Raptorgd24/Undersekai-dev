/// obj_battle_menu - Alarm[1]
/* placeholder de turno enemigo: aquí puedes poner daño al jugador, animaciones, etc.
   Por ahora solo volvemos al menú del jugador.
*/
mode = "menu";
if (instance_exists(obj_thebox)) {
    with (obj_thebox) {
        text = other.text_to_show;
        display_text = "";
        text_index = 0;
    }
}
// restaurar corazón al menú principal
if (instance_exists(obj_heart)) {
    with (obj_heart) {
        mode = "select";
        // colocar a la opción seleccionada
        x = other.boton_x_inicial + other.seleccion * other.boton_espaciado + 4;
        y = other.boton_y + 6;
    }
}
