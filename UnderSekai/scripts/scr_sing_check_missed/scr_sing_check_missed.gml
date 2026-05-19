/// scr_sing_check_missed(_sing_manager)
/// Marca notas como missed si pasaron sin ser golpeadas
function scr_sing_check_missed(_sing_manager) {
    with (_sing_manager) {
        var cur_time = song_position;
        
        for (var i = 0; i < ds_list_size(notes); i++) {
            var note = notes[| i];
            
            if (!note.hit && !note.missed) {
                // Si la nota pasó más allá de la ventana de timing_bad
                if (cur_time > note.time_ms + timing_bad) {
                    note.missed = true;
                    combo = 0;
                    notes_missed += 1;
                    
                    // Destruir visual si existe
                    if (variable_instance_exists(note, "visual_id") && instance_exists(note.visual_id)) {
                        with (note.visual_id) {
                            show_miss = true;
                            alarm[0] = room_speed * 0.5; // mostrar miss por 0.5s
                        }
                    }
                }
            }
        }
    }
}