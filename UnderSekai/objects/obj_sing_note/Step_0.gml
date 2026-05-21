if (sing_manager == noone || !instance_exists(sing_manager)) {
	instance_destroy();
	exit;
}

if (dead_timer > 0) {
	dead_timer -= 1;
	y -= 0.5;
	image_alpha = max(0, image_alpha - 0.06);
	if (dead_timer <= 0) instance_destroy();
	exit;
}

var cur_time = sing_manager.song_position;
var note_time = time_ms;
var approach_ms = sing_manager.chart_start_offset;

var t = 1 - clamp((note_time - cur_time) / approach_ms, 0, 1);
y = lerp(start_y, target_y, t);

if (cur_time > note_time + sing_manager.timing_bad && !hit && !missed) {
	missed = true;
	show_miss = true;
	hit_accuracy = "MISS";
	show_accuracy = true;
	dead_timer = 18;
}
