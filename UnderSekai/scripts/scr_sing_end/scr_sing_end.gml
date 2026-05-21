function scr_sing_end(_sing_manager) {
	if (!instance_exists(_sing_manager)) return;

	var _battle_ref = _sing_manager.battle_id;
	var _notes_hit = _sing_manager.notes_hit;
	var _notes_missed = _sing_manager.notes_missed;
	var _notes_list = _sing_manager.notes;
	var _score = _sing_manager.total_score;
	var _max_combo = _sing_manager.max_combo;
	var _total = max(1, _notes_hit + _notes_missed);
	var _accuracy = (_sing_manager.acc_points / _total) * 100;
	var _perf = _sing_manager.performance;

	var _rank = "F";
	if (_accuracy >= 98 && _notes_missed <= 0) {
		_rank = "S";
	} else if (_accuracy >= 90) {
		_rank = "A";
	} else if (_accuracy >= 78) {
		_rank = "B";
	} else if (_accuracy >= 65) {
		_rank = "C";
	} else if (_accuracy >= 45) {
		_rank = "D";
	}

	var _fame_given = 0;
	switch (_rank) {
		case "S": _fame_given = 120; break;
		case "A": _fame_given = 90; break;
		case "B": _fame_given = 60; break;
		case "C": _fame_given = 35; break;
		case "D": _fame_given = 15; break;
		default:  _fame_given = 0; break;
	}

	var _passed = (_rank != "F" && _perf > 0);

	global.sing_result = {
		score: _score,
		accuracy: _accuracy,
		rank: _rank,
		pass: _passed,
		fame: _fame_given,
		hit: _notes_hit,
		missed: _notes_missed,
		max_combo: _max_combo
	};

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

	if (instance_exists(obj_sing_ui)) {
		with (obj_sing_ui) instance_destroy();
	}

	instance_destroy(_sing_manager);

	if (instance_exists(_battle_ref)) {
		global.fame += _fame_given;

		with (_battle_ref) {
			selected_act = "SING";

			if (instance_exists(obj_thebox)) {
				obj_thebox.target_width = 280;
				obj_thebox.target_height = 78;
				obj_thebox.target_x = 25;
				obj_thebox.target_y = 110;
				obj_thebox.text = "* RESULTADO SING\n* Rango " + _rank + "  Precision " + string_format(_accuracy, 1, 1) + "%\n* Puntos " + string(_score) + "  +" + string(_fame_given) + " fama.";
				obj_thebox.display_text = "";
				obj_thebox.text_index = 0;
			}

			mode = "act_result";
		}
	}

	show_debug_message("sing end rank " + _rank + " acc " + string(_accuracy));
}
