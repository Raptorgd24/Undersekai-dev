// === HELPERS DE ENTRADA TACTIL (MOVIL) ===
// Todas las funciones de "tap" devuelven false en plataformas no moviles,
// asi que es seguro llamarlas siempre: en PC nunca se activan.

/// @function is_mobile()
/// @return {bool} true si el juego corre en Android o iOS
function is_mobile() {
    return (os_type == os_android || os_type == os_ios);
}

/// @function tap_pressed()
/// @desc true SOLO en el frame en que se toca la pantalla (dedo principal). Solo movil.
function tap_pressed() {
    return is_mobile() && device_mouse_check_button_pressed(0, mb_left);
}

// --- Coordenadas del toque en espacio GUI (para eventos Draw GUI / Draw_64) ---
/// @function tap_gui_x()
function tap_gui_x() { return device_mouse_x_to_gui(0); }
/// @function tap_gui_y()
function tap_gui_y() { return device_mouse_y_to_gui(0); }

/// @function tap_in(x1, y1, x2, y2)
/// @desc true si se toca dentro del rectangulo (coordenadas GUI). Solo movil.
function tap_in(_x1, _y1, _x2, _y2) {
    if (!tap_pressed()) return false;
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    return point_in_rectangle(_mx, _my, min(_x1, _x2), min(_y1, _y2), max(_x1, _x2), max(_y1, _y2));
}

/// @function tap_pressed_game()
/// @desc Como tap_pressed() pero IGNORA los toques que caen sobre los botones
///       de la UI movil (publicados por obj_mobile_control_manager). Util para
///       que tocar el boton de "volver" no cuente tambien como confirmar.
function tap_pressed_game() {
    if (!tap_pressed()) return false;
    if (variable_global_exists("mobile_ui_x1")) {
        var _mx = device_mouse_x_to_gui(0);
        var _my = device_mouse_y_to_gui(0);
        if (point_in_rectangle(_mx, _my, global.mobile_ui_x1, global.mobile_ui_y1, global.mobile_ui_x2, global.mobile_ui_y2)) {
            return false;
        }
    }
    return true;
}

// --- Coordenadas del toque en espacio de la ROOM/vista (para UI dibujada en el mundo) ---
/// @function tap_room_x()
function tap_room_x() { return device_mouse_x(0); }
/// @function tap_room_y()
function tap_room_y() { return device_mouse_y(0); }

/// @function tap_on_instance(obj)
/// @desc true si se toca encima de una instancia/objeto (coordenadas de room). Solo movil.
function tap_on_instance(_obj) {
    if (!tap_pressed()) return false;
    return position_meeting(device_mouse_x(0), device_mouse_y(0), _obj);
}
