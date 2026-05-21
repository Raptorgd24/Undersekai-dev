audio_play_sound(mus_options, 1, true);
scr_options_load();
scr_api_init();

var _login_label = global.api_logged_in
    ? ("LOGOUT (" + global.api_username + ")")
    : "LOGIN";

menu_options = ["RESOLUTION", "FULLSCREEN", "MASTER VOL", _login_label, "BACK"];
menu_index   = 0;

res_labels = ["320x240", "640x480", "960x720", "1280x960"];

font_menu = ft_determinationsans;