if (sing_manager == noone || !instance_exists(sing_manager)) exit;

var cam = view_camera[0];
var cam_x = camera_get_view_x(cam);
var cam_y = camera_get_view_y(cam);
var cam_w = camera_get_view_width(cam);

draw_set_font(ft_determinationsans);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);

var total = max(1, sing_manager.notes_hit + sing_manager.notes_missed);
var acc = (sing_manager.acc_points / total) * 100;
var txt_s = 0.42;
var lane_cols = [c_red, c_lime, c_aqua, c_yellow];

draw_set_color(make_color_rgb(10, 10, 18));
draw_rectangle(cam_x, cam_y, cam_x + cam_w, cam_y + 146, false);

draw_set_color(c_white);
draw_text_transformed(combo_x, combo_y, "COMBO " + string(sing_manager.combo), txt_s, txt_s, 0);

draw_set_halign(fa_left);
draw_text_transformed(accuracy_x, accuracy_y, string_format(acc, 1, 1) + "%", txt_s, txt_s, 0);

draw_set_halign(fa_right);
draw_text_transformed(score_x, score_y, string(sing_manager.total_score), txt_s, txt_s, 0);

var bar_x1 = cam_x + 24;
var bar_y1 = cam_y + 38;
var bar_x2 = cam_x + cam_w - 24;
var bar_y2 = cam_y + 43;
var perf = clamp(sing_manager.performance, 0, 100);

draw_set_color(c_dkgray);
draw_rectangle(bar_x1, bar_y1, bar_x2, bar_y2, false);
draw_set_color(merge_color(c_red, c_lime, perf / 100));
draw_rectangle(bar_x1, bar_y1, bar_x1 + (bar_x2 - bar_x1) * (perf / 100), bar_y2, false);

draw_set_color(c_yellow);
draw_line(lane_positions.D - 12, lane_y, lane_positions.K + 12, lane_y);

var lanes = ["D", "F", "J", "K"];
for (var i = 0; i < array_length(lanes); i++) {
	var lx = lane_positions[$ lanes[i]];
	var lane_col = lane_cols[i];

	draw_set_color(merge_color(c_gray, lane_col, 0.25));
	draw_line_width(lx, cam_y + 52, lx, lane_y + 10, 1);

	var flash = 0;
	if (array_length(sing_manager.lane_flash) > i) {
		flash = sing_manager.lane_flash[i];
	}

	var flash_t = clamp(flash / 8, 0, 1);
	var r_w = 10 + flash_t * 4;
	var r_h = 6 + flash_t * 3;

	draw_set_color(c_black);
	draw_rectangle(lx - r_w - 1, lane_y - r_h - 1, lx + r_w + 1, lane_y + r_h + 1, false);

	draw_set_color(merge_color(lane_col, c_white, flash_t * 0.45));
	draw_rectangle(lx - r_w, lane_y - r_h, lx + r_w, lane_y + r_h, false);

	draw_set_color(c_white);
	draw_rectangle(lx - r_w, lane_y - r_h, lx + r_w, lane_y + r_h, true);
}

draw_set_color(c_white);
draw_set_halign(fa_center);
for (var i = 0; i < array_length(lanes); i++) {
	draw_text_transformed(lane_positions[$ lanes[i]], lane_y + 8, lanes[i], txt_s, txt_s, 0);
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
