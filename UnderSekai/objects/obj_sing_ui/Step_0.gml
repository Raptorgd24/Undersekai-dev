// obj_sing_ui - Step

if (sing_manager == noone || !instance_exists(sing_manager)) {
	instance_destroy();
	exit;
}

var cam = view_camera[0];
var cam_x = camera_get_view_x(cam);
var cam_y = camera_get_view_y(cam);
var cam_w = camera_get_view_width(cam);

var lane_count = 4;
var total_lane_width = 110;
var lane_start_x = cam_x + (cam_w - total_lane_width) * 0.5;
var lane_spacing = total_lane_width / (lane_count - 1);

lane_y = cam_y + 126;
combo_x = cam_x + cam_w * 0.5;
combo_y = cam_y + 8;
accuracy_x = cam_x + 24;
accuracy_y = cam_y + 12;
score_x = cam_x + cam_w - 24;
score_y = cam_y + 12;
judge_x = cam_x + cam_w * 0.5;
judge_y = cam_y + 72;

lane_positions = {
	D: lane_start_x,
	F: lane_start_x + lane_spacing,
	J: lane_start_x + lane_spacing * 2,
	K: lane_start_x + lane_spacing * 3
};
