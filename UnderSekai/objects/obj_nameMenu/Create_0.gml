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

name_scale = 1;
target_scale = 1;

fade_alpha = 0;
fade_speed = 1/180;
fading = false;

fade_timer = 0;
fade_duration = 180; // 3 segundos exactos a 60fps
fade_done = false;

input_enabled = true;
input_delay = 0;

key_pop = 1;
cursor_timer = 0;
confirm_lock_timer = 0;

gpu_set_texfilter(false);
image_alpha =0;