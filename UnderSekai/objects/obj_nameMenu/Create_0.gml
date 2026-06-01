row = 0;
col = 0;

text_input = "";
max_chars = 6;

keyboard = [
    ["Q","W","E","R","T","Y","U","I","O","P"],
    ["A","S","D","F","G","H","J","K","L"],
    ["Z","X","C","V","B","N","M"],
    ["ENTER","RETURN"]
];

enum MenuState {
    INPUT,
    CONFIRM,
    BACK_ANIM
}

menu_state = MenuState.INPUT;
confirm_option = 0;

input_enabled = true;
input_delay = 0;
confirm_lock_timer = 0;

fade_alpha = 0;
fading = false;
fade_timer = 0;
fade_duration = 180;
fade_done = false;

gpu_set_texfilter(false);

text_obj = instance_create_layer(0, 0, "Instances", obj_nameMenuText);
text_obj.parent = id;

// === ENTRADA POR TECLADO DEL DISPOSITIVO (MOVIL) ===
keyboard_string = "";
if (os_type == os_android || os_type == os_ios) {
    keyboard_virtual_show(kbv_type_default, kbv_returnkey_done, kbv_autocapitalize_characters, false);
}