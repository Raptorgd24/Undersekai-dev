if (input_cooldown > 0) {
    input_cooldown--;
    exit;
}

if (waiting_req) {
    exit;
}

if (keyboard_check_pressed(vk_escape)) {
    room_goto(rm_options);
    exit;
}

var _ks = keyboard_string;
keyboard_string = "";

if (state == "username" || state == "password") {

    var _target = (state == "username") ? username_input : password_input;

    for (var i = 1; i <= string_length(_ks); i++) {
        var _c = string_char_at(_ks, i);
        var _o = ord(_c);
        if ((_o >= 32 && _o <= 126) && string_length(_target) < max_chars) {
            _target += _c;
        }
    }

    if (state == "username") username_input = _target;
    else password_input = _target;

    if (keyboard_check_pressed(vk_backspace)) {
        if (string_length(_target) > 0) {
            if (state == "username") username_input = string_delete(username_input, string_length(username_input), 1);
            else password_input = string_delete(password_input, string_length(password_input), 1);
        }
    }

    if (keyboard_check_pressed(vk_tab) || keyboard_check_pressed(vk_enter)) {
        if (state == "username") {
            state = "password";
        } else {
            state = "confirm";
        }
        input_cooldown = 8;
    }
}

if (state == "confirm") {
    if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {
        if (username_input == "" || password_input == "") {
            error_msg = "Rellena todos los campos.";
            state = "username";
            input_cooldown = 10;
        } else {
            waiting_req = true;
            status_msg  = "Conectando...";
            error_msg   = "";
            req_id = scr_api_login(username_input, password_input);
        }
    }
    if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift)) {
        state = "password";
        input_cooldown = 8;
    }
}