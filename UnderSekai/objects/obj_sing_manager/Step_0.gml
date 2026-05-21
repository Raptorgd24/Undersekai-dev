if (!chart_active) exit;

song_position += delta_time / 1000;

if (judge_timer > 0) {
	judge_timer -= 1;
}

for (var i = 0; i < array_length(key_lanes); i++) {
	if (lane_flash[i] > 0) {
		lane_flash[i] -= 1;
	}

	var mob_now = false;
	if (variable_global_exists("sing_mobile_lanes") && is_array(global.sing_mobile_lanes)) {
		if (array_length(global.sing_mobile_lanes) > i) {
			mob_now = global.sing_mobile_lanes[i];
		}
	}

	var mob_press = mob_now && !mobile_last[i];
	mobile_last[i] = mob_now;

	if (keyboard_check_pressed(key_codes[i]) || mob_press) {
		lane_flash[i] = 8;
		scr_sing_note_hit(id, key_lanes[i]);
	}
}

scr_sing_update(id);
scr_sing_check_missed(id);
