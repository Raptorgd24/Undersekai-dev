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

show_debug_message("Virtual Controls | Viewport GUI: " + string(gui_w) + "x" + string(gui_h));