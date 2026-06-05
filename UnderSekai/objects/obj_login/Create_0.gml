scr_api_init();

state = "username";

username_input = "";
password_input = "";
max_chars = 32;

error_msg   = "";
status_msg  = "";
waiting_req = false;
req_id      = -1;

input_cooldown = 10;

keyboard_string = "";

// MOVIL: mostrar el teclado del dispositivo para poder escribir
if (is_mobile()) {
    keyboard_virtual_show(kbv_type_default, kbv_returnkey_default, kbv_autocapitalize_none, false);
}