// ================= DRAW GUI =================

var sing_mode = false;
if (instance_exists(obj_battle_menu)) {
	var _bat = instance_find(obj_battle_menu, 0);
	if (instance_exists(_bat) && _bat.mode == "sing_chart") {
		sing_mode = true;
	}
}

if (sing_mode) {
	var gui_w = display_get_gui_width();
	var gui_h = display_get_gui_height();
	var lanes = ["D", "F", "J", "K"];
	var cols = [c_red, c_lime, c_aqua, c_yellow];
	var zone_w = gui_w / 4;

	draw_set_font(ft_determinationsans);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	for (var i = 0; i < 4; i++) {
		var x1 = zone_w * i;
		var x2 = zone_w * (i + 1);
		var pressed = false;

		if (variable_global_exists("sing_mobile_lanes") && is_array(global.sing_mobile_lanes)) {
			if (array_length(global.sing_mobile_lanes) > i) pressed = global.sing_mobile_lanes[i];
		}

		draw_set_alpha(pressed ? 0.30 : 0.16);
		draw_set_color(cols[i]);
		draw_rectangle(x1 + 2, 0, x2 - 2, gui_h, false);

		draw_set_alpha(pressed ? 0.75 : 0.45);
		draw_set_color(c_white);
		draw_line(x1 + 2, 0, x1 + 2, gui_h);

		draw_set_alpha(pressed ? 0.95 : 0.65);
		draw_set_color(cols[i]);
		draw_circle((x1 + x2) * 0.5, gui_h - 62, pressed ? 38 : 32, false);

		draw_set_color(c_white);
		draw_text_transformed((x1 + x2) * 0.5, gui_h - 65, lanes[i], 0.65, 0.65, 0);
	}

	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	exit;
}

draw_set_alpha(0.35);
draw_set_color(c_white);
draw_circle(joy_x, joy_y, joy_r, false);

draw_set_alpha(0.5);
draw_set_color(c_yellow);
draw_circle(stick_x, stick_y, stick_r, false);

// Botones
var bx = btn_x;
var by = btn_y;
var s  = btn_size;

// Z rojo
draw_set_color(c_red);
draw_rectangle(bx, by, bx + s, by + s, false);
draw_set_color(c_white);
draw_text(bx + s/2 - 12, by + s/2 - 12, "Z");

// X azul
draw_set_color(c_blue);
draw_rectangle(bx + s, by, bx + s*2, by + s, false);
draw_set_color(c_white);
draw_text(bx + s + s/2 - 12, by + s/2 - 12, "X");

// C verde
draw_set_color(c_green);
draw_rectangle(bx + s*2, by, bx + s*3, by + s, false);
draw_set_color(c_white);
draw_text(bx + s*2 + s/2 - 12, by + s/2 - 12, "C");

draw_set_alpha(1);
draw_set_color(c_white);
