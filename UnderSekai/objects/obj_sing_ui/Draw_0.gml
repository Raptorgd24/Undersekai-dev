if (sing_manager == noone || !instance_exists(sing_manager)) exit;
draw_set_font(ft_determinationsans);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);

draw_text(combo_x, combo_y, "Combo: " + string(sing_manager.combo));
draw_text(combo_x, combo_y + 25, "Max: " + string(sing_manager.max_combo));
draw_text(score_x, score_y, "Score: " + string(sing_manager.total_score));

draw_set_color(c_yellow);
draw_line(lane_positions.D - 20, lane_y, lane_positions.K + 20, lane_y);

draw_set_color(c_gray);
var lanes = ["D", "F", "J", "K"];
for (var i = 0; i < array_length(lanes); i++) {
    var lx = lane_positions[$ lanes[i]];
    draw_line_width(lx, lane_y - 30, lx, lane_y + 30, 3);
}

draw_set_color(c_white);
for (var i = 0; i < array_length(lanes); i++) {
    draw_text(lane_positions[$ lanes[i]], lane_y + 35, lanes[i]);
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);