/// scr_sing_end(_sing_manager)
/// Finaliza el charting, calcula fama otorgada y vuelve al flujo de batalla.
function scr_sing_end(_sing_manager) {
    if (!instance_exists(_sing_manager)) return;

    // Leer todo lo necesario ANTES de entrar en with / destruir la instancia
    var _battle_ref   = _sing_manager.battle_id;
    var _song_inst    = _sing_manager.song_instance;
    var _notes_hit    = _sing_manager.notes_hit;
    var _notes_missed = _sing_manager.notes_missed;
    var _notes_list   = _sing_manager.notes;

    // -- Pausar musica --------------------------------------------------------
    if (_song_inst >= 0 && audio_exists(_song_inst) && audio_is_playing(_song_inst)) {
        audio_pause_sound(_song_inst);
    }

    // -- Calcular accuracy y fama ---------------------------------------------
    var _total    = _notes_hit + _notes_missed;
    var _accuracy = 0;
    if (_total > 0) {
        _accuracy = (_notes_hit / _total) * 100;
    }

    var _fame_given = 0;
    if (_accuracy >= 95) {
        _fame_given = 100;
    } else if (_accuracy >= 85) {
        _fame_given = 75;
    } else if (_accuracy >= 75) {
        _fame_given = 50;
    } else if (_accuracy >= 25) {
        _fame_given = 25;
    }

    var _rank = "FAILED...";
    if (_fame_given >= 100) {
        _rank = "PERFECT!";
    } else if (_fame_given >= 75) {
        _rank = "EXCELLENT!";
    } else if (_fame_given >= 50) {
        _rank = "GOOD";
    } else if (_fame_given >= 25) {
        _rank = "FAIR";
    }

    // -- Destruir notas visuales y limpiar ds_list ----------------------------
    if (ds_exists(_notes_list, ds_type_list)) {
        for (var i = 0; i < ds_list_size(_notes_list); i++) {
            var _note = _notes_list[| i];
            if (is_undefined(_note)) continue;
            if (variable_struct_exists(_note, "visual_id") && instance_exists(_note.visual_id)) {
                instance_destroy(_note.visual_id);
            }
        }
        ds_list_destroy(_notes_list);
    }

    // -- Destruir UI ----------------------------------------------------------
    if (instance_exists(obj_sing_ui)) {
        with (obj_sing_ui) instance_destroy();
    }

    // -- Destruir el manager ANTES de tocar battle_id -------------------------
    instance_destroy(_sing_manager);

    // -- Notificar a la batalla -----------------------------------------------
    if (instance_exists(_battle_ref)) {
        global.fame += _fame_given;

with (_battle_ref) {
    selected_act = "SING";

    if (instance_exists(obj_thebox)) {
        obj_thebox.target_width  = 280;
        obj_thebox.target_height = 78;
        obj_thebox.target_x      = 25;
        obj_thebox.target_y      = 110;
        obj_thebox.text          = "* You sang! " + _rank + "\n* Gained " + string(_fame_given) + " fame!";
        obj_thebox.display_text  = "";
        obj_thebox.text_index    = 0;
    }

    mode = "act_result";
}
    }
}
