/// scr_sing_update(_sing_manager)
/// Actualiza el sistema de charting cada frame.
/// song_position ya fue incrementado en el Step antes de llamar aqui.
function scr_sing_update(_sing_manager) {
    if (!instance_exists(_sing_manager)) return;

    with (_sing_manager) {
        if (!chart_active) return;

        // -- Crear notas visuales cuando su tiempo se acerca ------------------
        for (var i = 0; i < ds_list_size(notes); i++) {
            var note = notes[| i];
            if (is_undefined(note)) continue;

            if (!variable_struct_exists(note, "visual_created")) note.visual_created = false;
            if (!variable_struct_exists(note, "visual_id"))      note.visual_id      = noone;
            if (!variable_struct_exists(note, "hit"))            note.hit             = false;
            if (!variable_struct_exists(note, "missed"))         note.missed          = false;

            // Mostrar la nota cuando quedan chart_start_offset ms para que llegue
            if (!note.visual_created && !note.hit && !note.missed
                && note.time_ms <= song_position + chart_start_offset) {

                var note_obj = instance_create_layer(0, 0, "Instances", obj_sing_note);
                if (instance_exists(note_obj)) {
                    note_obj.chart_data   = note;
                    note_obj.lane         = note.lane;
                    note_obj.time_ms      = note.time_ms;
                    note_obj.sing_manager = id;
                }
                note.visual_created = true;
                note.visual_id      = instance_exists(note_obj) ? note_obj : noone;
            }
        }

        // -- Comprobar fin del chart ------------------------------------------
        // Termina cuando todas las notas han sido procesadas
        var all_done = true;
        for (var j = 0; j < ds_list_size(notes); j++) {
            var n = notes[| j];
            if (!is_undefined(n) && !n.hit && !n.missed) {
                all_done = false;
                break;
            }
        }

        if (song_position >= song_duration || all_done) {
            chart_active = false;
            var _mgr_id = id;
            scr_sing_end(_mgr_id);
            return; // La instancia ya no existe tras scr_sing_end
        }
    }
}
