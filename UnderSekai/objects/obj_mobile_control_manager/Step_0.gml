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

// En batalla solo se muestra el boton de "volver" (X) en la esquina
var battle_active = instance_exists(obj_battle_menu);

// En batalla el joystick se desactiva SALVO durante el turno enemigo (para esquivar)
var battle_enemy_turn = false;
if (battle_active) {
	var _bm = instance_find(obj_battle_menu, 0);
	if (instance_exists(_bm)) battle_enemy_turn = (_bm.mode == "enemy_turn");
}
// Hay un dialogo abierto? -> tampoco se puede sacar el joystick
var dialogue_open = false;
if (variable_global_exists("dialogue_active") && global.dialogue_active) dialogue_open = true;
if (!dialogue_open && variable_global_exists("dialogue_manager") && is_struct(global.dialogue_manager)) {
	dialogue_open = global.dialogue_manager.active;
}

var joystick_allowed = (!battle_active || battle_enemy_turn) && !dialogue_open;

// Si el joystick no esta permitido, soltarlo (deja de mover)
if (!joystick_allowed) joy_finger = -1;

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

// Anclar los botones a la esquina inferior derecha segun el tamaño REAL del GUI
// (el GUI puede cambiar de tamaño con la resolucion, por eso se recalcula cada frame)
btn_x = display_get_gui_width()  - (btn_size * 3) - 2;
btn_y = display_get_gui_height() - btn_size - 2;

// ================= TOUCH IDS (0-4 maximo tipico) =================
for (var i = 0; i < 5; i++) {

	var mx = device_mouse_x_to_gui(i);
	var my = device_mouse_y_to_gui(i);

	var pressed = device_mouse_check_button(i, mb_left);

	// ================= JOYSTICK (flotante) =================
	// Aparece solo al tocar la mitad IZQUIERDA y se centra donde cae el dedo
	if (joystick_allowed && joy_finger == -1 && pressed) {
		if (mx < display_get_gui_width() * 0.5) {
			joy_finger = i;
			joy_x   = mx;   // el joystick nace bajo el dedo
			joy_y   = my;
			stick_x = mx;
			stick_y = my;
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

		if (battle_active) {
			// En batalla: solo el boton de volver (X) en la esquina derecha
			if (point_in_rectangle(mx, my, bx + s * 2, by, bx + s * 3, by + s)) x_btn = true;
		} else {
			if (point_in_rectangle(mx, my, bx, by, bx + s, by + s)) z_btn = true;
			if (point_in_rectangle(mx, my, bx + s, by, bx + s * 2, by + s)) x_btn = true;
			// El boton C (inventario) solo responde una vez empezado el juego
			if ((variable_global_exists("game_started") && global.game_started)
			    && point_in_rectangle(mx, my, bx + s * 2, by, bx + s * 3, by + s)) c_btn = true;
		}
	}
}

// Publicar el rectangulo de los botones visibles (para tap_pressed_game)
global.mobile_ui_y1 = btn_y;
global.mobile_ui_y2 = btn_y + btn_size;
if (battle_active) {
	global.mobile_ui_x1 = btn_x + btn_size * 2;   // solo el boton de volver
	global.mobile_ui_x2 = btn_x + btn_size * 3;
} else {
	global.mobile_ui_x1 = btn_x;
	global.mobile_ui_x2 = btn_x + btn_size * 3;
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
