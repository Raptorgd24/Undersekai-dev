function scr_sing_load_chart(_sing_manager, _chart_data) {
	if (!instance_exists(_sing_manager)) return false;

	with (_sing_manager) {
		if (ds_exists(notes, ds_type_list)) {
			ds_list_clear(notes);
		}

		total_notes = array_length(_chart_data);
		notes_hit = 0;
		notes_missed = 0;
		acc_points = 0;
		total_score = 0;
		combo = 0;
		max_combo = 0;
		performance = 65;
		last_judge = "";
		judge_timer = 0;

		for (var i = 0; i < array_length(_chart_data); i++) {
			var raw = _chart_data[i];
			var note_data = {
				time_ms: raw.time_ms,
				lane: raw.lane,
				type: "normal",
				hit: false,
				missed: false,
				visual_created: false,
				visual_id: noone
			};

			if (variable_struct_exists(raw, "type")) {
				note_data.type = raw.type;
			}

			ds_list_add(notes, note_data);
		}

		show_debug_message("chart cargado: " + string(total_notes) + " notas");
	}

	return true;
}
