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

// ================= BOTONES (spr_buttonsmobile) =================
// Frames: 0 = mano (Z) | 1 = flecha atras | 2 = correr (X) | 3 = bolsa (C)
var bx = btn_x;
var by = btn_y;
var s  = btn_size;

// El sprite es 64x64; lo escalamos al tamano del boton
var spr_scale = s / sprite_get_width(spr_buttonsmobile);

// Estamos en un menu? -> X muestra "volver atras" en vez de "correr"
var in_menu = instance_exists(obj_menuoverworld) || instance_exists(obj_nameMenu);

// El boton de inventario (C) solo aparece una vez empezado el juego
var show_c = (variable_global_exists("game_started") && global.game_started);

// Puede interactuar? (objeto delante, dialogo activo o menu abierto)
var can_z = false;
if (variable_global_exists("can_interact") && global.can_interact) can_z = true;
if (variable_global_exists("dialogue_active") && global.dialogue_active) can_z = true;
if (in_menu) can_z = true;

// --- Boton Z (mano) : transparente salvo que se pueda interactuar ---
var z_alpha = (can_z || is_z) ? btn_alpha_on : btn_alpha_dim;
draw_sprite_ext(spr_buttonsmobile, 0, bx, by, spr_scale, spr_scale, 0, c_white, z_alpha);

// --- Boton X : correr (frame 2) o volver atras (frame 1) en menus ---
var x_frame = in_menu ? 1 : 2;
var x_alpha = is_x ? btn_alpha_on : btn_alpha_idle;
draw_sprite_ext(spr_buttonsmobile, x_frame, bx + s, by, spr_scale, spr_scale, 0, c_white, x_alpha);

// --- Boton C (bolsa) : solo si el juego ya empezo ---
if (show_c) {
	var c_alpha = is_c ? btn_alpha_on : btn_alpha_idle;
	draw_sprite_ext(spr_buttonsmobile, 3, bx + s * 2, by, spr_scale, spr_scale, 0, c_white, c_alpha);
}

draw_set_alpha(1);
draw_set_color(c_white);
