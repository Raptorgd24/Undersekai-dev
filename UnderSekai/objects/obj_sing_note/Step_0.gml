if (sing_manager == noone || !instance_exists(sing_manager)) {
    instance_destroy();
    return;
}

var cur_time = sing_manager.song_position;
var note_time = time_ms;
var approach_ms = 600;

var t = 1 - clamp((note_time - cur_time) / approach_ms, 0, 1);
y = lerp(start_y, target_y, t);

if (cur_time > note_time + sing_manager.timing_bad && !hit) {
    instance_destroy();
}