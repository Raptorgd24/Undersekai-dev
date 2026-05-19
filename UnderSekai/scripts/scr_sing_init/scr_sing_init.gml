/// scr_sing_init(_battle_id)
/// Inicializa el sistema de charting para el minijuego Sing.
/// Retorna el id del sing_manager creado, o noone si falla.
function scr_sing_init(_battle_id) {

    // --- Limpiar cualquier manager anterior ---
    if (instance_exists(obj_sing_manager)) {
        with (obj_sing_manager) {
            if (ds_exists(notes, ds_type_list)) ds_list_destroy(notes);
            instance_destroy();
        }
    }
    if (instance_exists(obj_sing_ui)) {
        with (obj_sing_ui) instance_destroy();
    }

    // --- Validar battle_id ---
    if (!instance_exists(_battle_id)) {
        show_debug_message("[scr_sing_init] ERROR: _battle_id no existe.");
        return noone;
    }

    // --- Obtener song_instance del battle_id de forma segura ---
    var _song_inst = noone;
    if (variable_instance_exists(_battle_id, "song_instance")) {
        _song_inst = _battle_id.song_instance;
    }

    // Validar que haya audio reproduciéndose
    if (_song_inst == noone || !audio_exists(_song_inst) || !audio_is_playing(_song_inst)) {
        show_debug_message("[scr_sing_init] ADVERTENCIA: song_instance inválido (" + string(_song_inst) + "). Comprueba que la música de batalla esté activa.");
        // Intentar recuperar desde global por si acaso
        if (variable_global_exists("song_inst") && audio_exists(global.song_inst) && audio_is_playing(global.song_inst)) {
            _song_inst = global.song_inst;
            show_debug_message("[scr_sing_init] Usando global.song_inst como fallback.");
        }
    }

    // --- Crear el manager ---
    // El Create de obj_sing_manager ya inicializa todas las variables base,
    // incluyendo el ds_list 'notes'. No lo recreamos aquí.
    var sing_mgr = instance_create_layer(0, 0, "Instances", obj_sing_manager);

    if (!instance_exists(sing_mgr)) {
        show_debug_message("[scr_sing_init] ERROR: No se pudo crear obj_sing_manager.");
        return noone;
    }

    // --- Asignar referencias ---
    sing_mgr.battle_id    = _battle_id;
    sing_mgr.song_instance = _song_inst;

    // Calcular duración de forma segura
    var _songbattle = noone;
    if (variable_instance_exists(_battle_id, "songbattle")) {
        _songbattle = _battle_id.songbattle;
    }
    if (_songbattle != noone && audio_exists(_songbattle)) {
        var _len = audio_sound_length(_songbattle);
        // audio_sound_length puede devolver 0 en streams; poner un mínimo razonable
        sing_mgr.song_duration = (_len > 0) ? (_len * 1000) : 30000;
    } else {
        sing_mgr.song_duration = 30000; // 30 s por defecto
    }

    sing_mgr.song_position      = 0;
    sing_mgr.chart_start_offset = 500; // ms antes de que bajen las primeras notas

    // Puntuación
    sing_mgr.combo        = 0;
    sing_mgr.max_combo    = 0;
    sing_mgr.total_score  = 0;
    sing_mgr.fame_given   = 0;
    sing_mgr.notes_hit    = 0;
    sing_mgr.notes_missed = 0;

    // Ventanas de timing (ms)
    sing_mgr.timing_sick = 45;   // ±45 ms = Sick  (un poco más generoso para no frustar)
    sing_mgr.timing_good = 90;   // ±90 ms = Good
    sing_mgr.timing_bad  = 150;  // ±150ms = Bad

    // Control
    sing_mgr.show_combo    = true;
    sing_mgr.chart_end_time = 0;
    // chart_active se mantiene en false; se activa en battle_menu DESPUÉS de cargar el chart.

    // --- Crear UI ---
    instance_create_layer(0, 0, "Instances", obj_sing_ui);

    show_debug_message("[scr_sing_init] Inicializado correctamente. song_instance=" + string(_song_inst));
    return sing_mgr;
}
