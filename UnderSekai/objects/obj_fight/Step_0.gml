/// @function execute_action()
function execute_action() {
    // Recuperar la instancia del menú de batalla
    var b = noone;
    if (variable_global_exists("battle_menu") && instance_exists(global.battle_menu)) {
        b = global.battle_menu;
    } else {
        // fallback: intentar encontrar la instancia en la room
        if (instance_exists(obj_battle_menu)) b = instance_find(obj_battle_menu, 0);
        if (b != noone) global.battle_menu = b;
    }

    if (b == noone) {
        show_debug_message("ERROR: no se encontró obj_battle_menu al iniciar FIGHT");
        return;
    }

    var ename = b.enemyName;

    // Mostrar nombre del enemigo en el cuadro de texto
    if (instance_exists(obj_thebox)) {
        with (obj_thebox) {
            text = "* " + ename;
            display_text = "";
            text_index = 0;
        }
    }

    // Cambiar el modo del corazón — usamos la referencia b directamente
    if (instance_exists(obj_heart)) {
        with (obj_heart) {
            mode = "fight_select";
            // Coloca el corazón relativo a la caja del menú
            x = b.box_x + 20; // ajusta estos offsets según tu layout
            y = b.box_y + 20;
        }
    }

    show_debug_message("FIGHT started against " + ename);
}


