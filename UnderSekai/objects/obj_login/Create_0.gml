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