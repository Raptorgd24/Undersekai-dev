if (!(os_type == os_android || os_type == os_ios)) {
    instance_destroy();
    exit;
}

// === USAR EL TAMAÑO DEL VIEWPORT (640x480) ===
var gui_w = 640;   // ← tamaño del Viewport
var gui_h = 480;

display_set_gui_size(gui_w, gui_h);   // Forzamos el GUI al tamaño del viewport

// Configuración de controles (ajustados a 640x480)
joy_r     = 55;
stick_r   = 23;
btn_size  = 72;
pad       = 25;

// Posiciones relativas al viewport 640x480
joy_x = 110 + pad;
joy_y = gui_h - 110 - pad;

stick_x = joy_x;
stick_y = joy_y;

joy_finger = -1;

btn_x = gui_w - (btn_size * 3) - pad - 10;   // un poco más separado
btn_y = gui_h - btn_size - pad;

// === ESTADO DE BOTONES (spr_buttonsmobile) ===
// Frames del sprite: 0 = mano (Z), 1 = flecha atras (X en menu), 2 = correr (X), 3 = bolsa (C)
if (!variable_global_exists("can_interact")) global.can_interact = false;
if (!variable_global_exists("game_started")) global.game_started = false;

// Estado de pulsado para feedback visual
is_z = false;
is_x = false;
is_c = false;

// Alphas
btn_alpha_dim  = 0.40;   // Z cuando NO se puede interactuar
btn_alpha_idle = 0.85;   // X / C en reposo (siempre visibles)
btn_alpha_on   = 1.00;   // boton activo / pulsado

show_debug_message("Virtual Controls | Viewport GUI: " + string(gui_w) + "x" + string(gui_h));