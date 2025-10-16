/// @description Inserte aquí la descripción
// Puede escribir su código en este editor
function execute_action() {
    if (instance_exists(obj_thebox)) {
        with (obj_thebox) {
            text = "* You spare the enemy.";
            display_text = "";
            text_index = 0;
        }
    }
    // Aquí podrías terminar el combate o cambiar a un estado de "fin de batalla"
    show_debug_message("MERCY selected");
}
