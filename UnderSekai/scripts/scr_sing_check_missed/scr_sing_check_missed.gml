function scr_sing_check_missed(_sing_manager) {
	if (!instance_exists(_sing_manager)) return;

	with (_sing_manager) {
		var cur_time = song_position;

		for (var i = 0; i < ds_list_size(notes); i++) {
			var note = notes[| i];
			if (is_undefined(note)) continue;

			if (!note.hit && !note.missed && cur_time > note.time_ms + timing_bad) {
				note.missed = true;
				combo = 0;
				notes_missed += 1;
				performance = clamp(performance - 8, 0, 100);
				last_judge = "MISS";
				judge_timer = 28;
				last_lane = note.lane;

				if (variable_struct_exists(note, "visual_id") && instance_exists(note.visual_id)) {
					var _vis = note.visual_id;
					with (_vis) {
						missed = true;
						show_miss = true;
						hit_accuracy = "MISS";
						show_accuracy = true;
						alarm[0] = 20;
					}
				}

				show_debug_message("nota MISS " + note.lane);
			}
		}
	}
}
