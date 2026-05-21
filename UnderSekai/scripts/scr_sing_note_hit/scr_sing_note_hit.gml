function scr_sing_note_hit(_sing_manager, _lane) {
	if (!instance_exists(_sing_manager)) {
		return { hit: false, accuracy: "MISS", points: 0 };
	}

	with (_sing_manager) {
		var cur_time = song_position;
		var best_note = noone;
		var best_distance = 999999;

		for (var i = 0; i < ds_list_size(notes); i++) {
			var note = notes[| i];

			if (!is_undefined(note) && note.lane == _lane && !note.hit && !note.missed) {
				var time_diff = abs(note.time_ms - cur_time);

				if (time_diff < best_distance && time_diff <= timing_bad) {
					best_note = note;
					best_distance = time_diff;
				}
			}
		}

		if (best_note != noone) {
			best_note.hit = true;

			var accuracy = "GOOD";
			var points = 100;
			var acc_add = 0.55;

			if (best_distance <= timing_perfect) {
				accuracy = "PERFECT";
				points = 300;
				acc_add = 1;
			} else if (best_distance <= timing_great) {
				accuracy = "GREAT";
				points = 200;
				acc_add = 0.82;
			} else if (best_distance <= timing_good) {
				accuracy = "GOOD";
				points = 100;
				acc_add = 0.55;
			} else {
				accuracy = "BAD";
				points = 40;
				acc_add = 0.25;
			}

			combo += 1;
			if (combo > max_combo) max_combo = combo;

			total_score += points + combo * 3;
			notes_hit += 1;
			acc_points += acc_add;
			performance = clamp(performance + 3 + acc_add * 3, 0, 100);
			last_judge = accuracy;
			judge_timer = 32;
			last_lane = _lane;

			if (variable_struct_exists(best_note, "visual_id") && instance_exists(best_note.visual_id)) {
				var _vis = best_note.visual_id;
				_vis.hit = true;
				_vis.hit_accuracy = accuracy;
				_vis.show_accuracy = true;
				_vis.image_alpha = 1;
				_vis.alarm[1] = 18;
			}

			show_debug_message("nota " + accuracy + " " + _lane + " +" + string(points));

			return {
				hit: true,
				accuracy: accuracy,
				points: points
			};
		}

		combo = 0;
		performance = clamp(performance - 4, 0, 100);
		last_judge = "MISS";
		judge_timer = 24;
		last_lane = _lane;

		return {
			hit: false,
			accuracy: "MISS",
			points: 0
		};
	}

	return { hit: false, accuracy: "MISS", points: 0 };
}
