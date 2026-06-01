// Si no existe el probe de interaccion, no se puede interactuar
if (!instance_exists(obj_usable)) global.can_interact = false;

// reset input cada frame
var left = false;
var right = false;
var up = false;
var down = false;

var z_btn = false;
var x_btn = false;
var c_btn = false;

var sing_mode = false;
if (instance_exists(obj_battle_menu)) {
	var _bat = instance_find(obj_battle_menu, 0);
	if (instance_exists(_bat) && _bat.mode == "sing_chart") {
		sing_mode = true;
	}
}

global.sing_mobile_lanes = [false, false, false, false];

if (sing_mode) {
	keyboard_key_release(vk_left);
	keyboard_key_release(vk_right);
	keyboard_key_release(vk_up);
	keyboard_key_release(vk_down);
	keyboard_key_release(ord("Z"));
	keyboard_key_release(ord("X"));
	keyboard_key_release(ord("C"));

	var gui_w = display_get_gui_width();
	var gui_h = display_get_gui_height();

	for (var i = 0; i < 5; i++) {
		var mx = device_mouse_x_to_gui(i);
		var my = device_mouse_y_to_gui(i);
		var pressed = device_mouse_check_button(i, mb_left);

		if (pressed) {
			var lane = clamp(floor(mx / (gui_w / 4)), 0, 3);
			global.sing_mobile_lanes[lane] = true;
		}
	}

	exit;
}

// ================= TOUCH IDS (0-4 maximo tipico) =================
for (var i = 0; i < 5; i++) {

	var mx = device_mouse_x_to_gui(i);
	var my = device_mouse_y_to_gui(i);

	var pressed = device_mouse_check_button(i, mb_left);

	// ================= JOYSTICK =================
	if (joy_finger == -1 && pressed) {
		if (point_distance(mx, my, joy_x, joy_y) < joy_r) {
			joy_finger = i;
		}
	}

	if (joy_finger == i) {

		if (!pressed) {
			joy_finger = -1;
			stick_x = joy_x;
			stick_y = joy_y;
		} else {

			var dx = mx - joy_x;
			var dy = my - joy_y;

			var len = point_distance(0, 0, dx, dy);

			if (len > joy_r) {
				dx = dx / len * joy_r;
				dy = dy / len * joy_r;
			}

			stick_x = joy_x + dx;
			stick_y = joy_y + dy;

			var dead = 20;

			if (dx < -dead) left = true;
			if (dx > dead) right = true;
			if (dy < -dead) up = true;
			if (dy > dead) down = true;
		}
	}

	// ================= BOTONES =================
	var bx = btn_x;
	var by = btn_y;
	var s = btn_size;

	if (pressed) {

		if (point_in_rectangle(mx, my, bx, by, bx + s, by + s)) z_btn = true;
		if (point_in_rectangle(mx, my, bx + s, by, bx + s * 2, by + s)) x_btn = true;
		// El boton C (inventario) solo responde una vez empezado el juego
		if ((variable_global_exists("game_started") && global.game_started)
		    && point_in_rectangle(mx, my, bx + s * 2, by, bx + s * 3, by + s)) c_btn = true;
	}
}

// Guardar estado de pulsado para el dibujado
is_z = z_btn;
is_x = x_btn;
is_c = c_btn;

// MOVIMIENTO
if (left)  keyboard_key_press(vk_left);  else keyboard_key_release(vk_left);
if (right) keyboard_key_press(vk_right); else keyboard_key_release(vk_right);
if (up)    keyboard_key_press(vk_up);    else keyboard_key_release(vk_up);
if (down)  keyboard_key_press(vk_down);  else keyboard_key_release(vk_down);

// BOTONES
if (z_btn) keyboard_key_press(ord("Z")); else keyboard_key_release(ord("Z"));
if (x_btn) keyboard_key_press(ord("X")); else keyboard_key_release(ord("X"));
if (c_btn) keyboard_key_press(ord("C")); else keyboard_key_release(ord("C"));
