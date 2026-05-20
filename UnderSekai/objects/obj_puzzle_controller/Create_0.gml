order = [1,2,3,4,5,6];
progress = 0;
solved = false;

function check_input(_id) {

    show_debug_message("Boton pulsado: " + string(_id));

    if (solved) return;

    if (_id == order[progress]) {
        
        progress++;
        show_debug_message("Correcto. Progreso: " + string(progress));

        if (progress >= array_length(order)) {
            solved = true;
            show_debug_message("PUZZLE COMPLETADO");

            with (obj_spikes) {
                active = false;
				image_index = 1;
				scr_set_global_data("Spikes1",true)

            }
        }

    } else {
        show_debug_message("FALLO");
        progress = 0;

        with (obj_button) {
            active = false;
            image_index = 0;
        }
    }
}