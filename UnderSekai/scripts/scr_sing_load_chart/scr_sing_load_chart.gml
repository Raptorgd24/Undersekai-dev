/// scr_sing_load_chart(_sing_manager, _chart_data)
/// Carga un chart de notas en el sistema
function scr_sing_load_chart(_sing_manager, _chart_data) {
    with (_sing_manager) {
        // Limpiar notas anteriores
        if (ds_list_size(notes) > 0) {
            ds_list_clear(notes);
        }
        
        // Cargar nuevo chart
        // _chart_data es un array de estructuras con:
        // { time_ms: número, lane: "D"|"F"|"J"|"K", type: "normal"|"hold" }
        
        for (var i = 0; i < array_length(_chart_data); i++) {
            var note_data = _chart_data[i];
            // Inicializar flags
            note_data.hit = false;
            note_data.missed = false;
            note_data.visual_created = false;
            note_data.visual_id = noone;
            
            ds_list_add(notes, note_data);
        }
    }
}
