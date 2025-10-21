// obj_fight - Script / Step
/// execute_action() - abre la selección de "fight" (muestra nombre enemigo y cambia modo del corazón)
function execute_action() {
    var b = noone;
    if (variable_global_exists("battle_menu") && instance_exists(global.battle_menu)) {
        b = global.battle_menu;
    } else {
        if (instance_exists(obj_battle_menu)) b = instance_find(obj_battle_menu, 0);
        if (b != noone) global.battle_menu = b;
    }

    if (b == noone) {
        show_debug_message("ERROR: no se encontró obj_battle_menu al iniciar FIGHT");
        return;
    }

    var ename = b.enemyName;

    // Mostrar nombre en caja
    if (instance_exists(obj_thebox)) {
        with (obj_thebox) {
            text = "* " + ename;
            display_text = "";
            text_index = 0;
        }
    }

    // Cambiar modo del corazón y posicionarlo
    if (instance_exists(obj_heart)) {
        with (obj_heart) {
            mode = "fight_select";
            x = b.box_x + 20;
            y = b.box_y + 20;
            target_x = x;
            target_y = y;
        }
    }

    // Actualizamos el estado del menú para que el Step del menú se encargue del resto
    with (b) {
        mode = "enemy_select";
    }

    show_debug_message("FIGHT started against " + ename);
}
