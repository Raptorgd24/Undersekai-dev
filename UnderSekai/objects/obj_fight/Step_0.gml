/// @description Inserte aquí la descripción
// Puede escribir su código en este editor
function execute_action() {
    if (instance_exists(obj_thebox)) {
        with (obj_thebox) {
            text = "* You attack fiercely!";
            display_text = "";
            text_index = 0;
        }
    }
    // Aquí podrías iniciar la animación del golpe o transición a modo "battle"
    show_debug_message("FIGHT selected");
}
