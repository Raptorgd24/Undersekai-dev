/// @description Inserte aquí la descripción
// Puede escribir su código en este editor
function execute_action() {
    if (instance_exists(obj_thebox)) {
        with (obj_thebox) {
            text = "* You are fucking cooked.";
            display_text = "";
            text_index = 0;
        }
    }
    // Puedes abrir un submenú de ACT (como “Check”, “Compliment”, etc.)
    show_debug_message("ACT selected");
}
