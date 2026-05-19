/// scr_sing_note_hit(_sing_manager, _lane)
/// Detecta si una nota fue golpeada correctamente
function scr_sing_note_hit(_sing_manager, _lane) {
    with (_sing_manager) {
        var cur_time = song_position;
        var best_note = noone;
        var best_distance = infinity;
        
        // Encontrar la nota más cercana en el tiempo para esta lane
        for (var i = 0; i < ds_list_size(notes); i++) {
            var note = notes[| i];
            
            if (note.lane == _lane && !note.hit && !note.missed) {
                var time_diff = abs(note.time_ms - cur_time);
                
                if (time_diff < best_distance && time_diff <= timing_bad) {
                    best_note = note;
                    best_distance = time_diff;
                }
            }
        }
        
        if (best_note != noone) {
            best_note.hit = true;
            var accuracy = "";
            var points = 0;
            
            // Determinar accuracy
            if (best_distance <= timing_sick) {
                accuracy = "SICK";
                points = 300;
            } else if (best_distance <= timing_good) {
                accuracy = "GOOD";
                points = 150;
            } else if (best_distance <= timing_bad) {
                accuracy = "BAD";
                points = 50;
            }
            
            combo += 1;
            if (combo > max_combo) max_combo = combo;
            total_score += points;
            notes_hit += 1;
            
            return {
                hit: true,
                accuracy: accuracy,
                points: points
            };
        } else {
            // Si no hay nota, es un Miss (golpe sin propósito)
            combo = 0;
            return {
                hit: false,
                accuracy: "MISS",
                points: 0
            };
        }
    }
    
    return {
        hit: false,
        accuracy: "MISS",
        points: 0
    };
}