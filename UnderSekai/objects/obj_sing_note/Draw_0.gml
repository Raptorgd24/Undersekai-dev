var lane_colors = {
    D: c_red,
    F: c_lime,
    J: c_blue,
    K: c_yellow
};

var col = lane_colors[$ lane];
draw_set_font(ft_determinationsans);
if (!hit) {
    draw_set_color(col);
    draw_rectangle(x - 12, y - 6, x + 12, y + 6, false);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(ft_determinationsans);
    draw_text(x, y, lane);
}

if (show_accuracy) {
    draw_set_color(c_yellow);
    draw_set_halign(fa_center);
    draw_text(x, y - 14, hit_accuracy);
}

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
