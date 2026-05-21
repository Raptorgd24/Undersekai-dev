function scr_sing_update(_sing_manager) {
	if (!instance_exists(_sing_manager)) return;

	with (_sing_manager) {
		if (!chart_active) return;

		for (var i = 0; i < ds_list_size(notes); i++) {
			var note = notes[| i];
			if (is_undefined(note)) continue;

			if (!note.visual_created && !note.hit && !note.missed && note.time_ms <= song_position + chart_start_offset) {
				var note_obj = instance_create_layer(0, 0, "Instances", obj_sing_note);

				if (instance_exists(note_obj)) {
					note_obj.chart_data = note;
					note_obj.lane = note.lane;
					note_obj.time_ms = note.time_ms;
					note_obj.sing_manager = id;
					note_obj.target_y = 126;

					if (instance_exists(obj_sing_ui)) {
						note_obj.x = obj_sing_ui.lane_positions[$ note.lane];
						note_obj.target_y = obj_sing_ui.lane_y;
						note_obj.start_y = obj_sing_ui.lane_y - 66;
						note_obj.y = note_obj.start_y;
					} else {
						note_obj.x = note_obj.lane_positions[$ note.lane];
					}
				}

				note.visual_created = true;
				note.visual_id = instance_exists(note_obj) ? note_obj : noone;
			}
		}

		var all_done = true;
		for (var j = 0; j < ds_list_size(notes); j++) {
			var n = notes[| j];
			if (!is_undefined(n) && !n.hit && !n.missed) {
				all_done = false;
				break;
			}
		}

		if (all_done || song_position >= song_duration) {
			if (!chart_finished) {
				chart_finished = true;
				finish_timer = 20;
			}
		}

		if (chart_finished) {
			finish_timer -= 1;
			if (finish_timer <= 0) {
				chart_active = false;
				scr_sing_end(id);
			}
		}
	}
}
