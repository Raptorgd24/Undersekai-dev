draw_set_font(ft_determinationsans);
var lane_colors = {
	D: c_red,
	F: c_lime,
	J: c_aqua,
	K: c_yellow
};

var col = lane_colors[$ lane];
var txt_s = 0.42;

draw_set_alpha(image_alpha);

if (!hit && !missed) {
	draw_set_color(col);
	draw_rectangle(x - 7, y - 4, x + 7, y + 4, false);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_transformed(x, y - 4, lane, txt_s, txt_s, 0);
}

if (show_accuracy) {
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	var pop_left = max(alarm[0], alarm[1]);
	var pop_max = 20;
	var pop_t = 1 - clamp(pop_left / pop_max, 0, 1);
	var pop_s = 0.36 + sin(pop_t * pi) * 0.22 + (1 - pop_t) * 0.10;
	var pop_y = y - 13 - pop_t * 8;

	switch (hit_accuracy) {
		case "PERFECT": draw_set_color(c_aqua); break;
		case "GREAT":   draw_set_color(c_lime); break;
		case "GOOD":    draw_set_color(c_yellow); break;
		default:        draw_set_color(c_red); break;
	}

	var pop_col = draw_get_color();

	draw_set_color(c_black);
	draw_text_transformed(x + 1, pop_y + 1, hit_accuracy, pop_s, pop_s * 0.92, 0);
	draw_text_transformed(x - 1, pop_y + 1, hit_accuracy, pop_s, pop_s * 0.92, 0);

	draw_set_color(pop_col);
	draw_text_transformed(x, pop_y, hit_accuracy, pop_s, pop_s, 0);

	draw_set_color(c_white);
	draw_text_transformed(x, pop_y - 1, hit_accuracy, pop_s * 0.92, pop_s * 0.92, 0);
}

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
