if (sing_manager == noone || !instance_exists(sing_manager)) return;

var lane_keys = ["D", "F", "J", "K"];
var lane_colors = [c_red, c_lime, c_blue, c_yellow];
var lane_x_pos = [60, 100, 140, 180];
var strum_y = 210;
var strum_w = 28;
var strum_h = 10;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

for (var i = 0; i < 4; i++) {
    var lx = lane_x_pos[i];
    
    draw_set_color(c_dkgray);
    draw_rectangle(lx - strum_w * 0.5, 0, lx + strum_w * 0.5, strum_y - strum_h * 0.5, false);
    
    var is_pressed = keyboard_check(ord(lane_keys[i]));
    var strum_col = is_pressed ? lane_colors[i] : merge_color(lane_colors[i], c_black, 0.5);
    
    draw_set_color(strum_col);
    draw_rectangle(lx - strum_w * 0.5, strum_y - strum_h * 0.5, lx + strum_w * 0.5, strum_y + strum_h * 0.5, false);
    
    draw_set_color(c_white);
    draw_set_font(ft_determinationsans);
    draw_text(lx, strum_y, lane_keys[i]);
}

draw_set_color(c_white);
draw_set_font(ft_determinationsans);
draw_set_halign(fa_center);
draw_text(combo_x, combo_y, "x" + string(sing_manager.combo));
draw_text(score_x, score_y, string(sing_manager.total_score));

draw_set_halign(fa_left);
draw_set_valign(fa_top);