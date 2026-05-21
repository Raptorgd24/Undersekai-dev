draw_set_font(ft_determinationsans);
gpu_set_texfilter(false);

var cx = display_get_gui_width()  * 0.5;
var cy = display_get_gui_height() * 0.5;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(c_white);
draw_text(cx, cy - 80, "LOGIN");

draw_set_halign(fa_left);
var label_x  = cx - 100;
var field_x  = cx - 60;
var field_w  = 180;

draw_set_color(c_white);
draw_text(label_x, cy - 40, "Usuario:");
var user_col = (state == "username") ? c_yellow : c_white;
draw_set_color(user_col);
draw_text(field_x, cy - 20, username_input + ((state == "username" && (current_time div 400) mod 2 == 0) ? "_" : ""));

draw_set_color(c_white);
draw_text(label_x, cy + 10, "Password:");
var pass_col = (state == "password") ? c_yellow : c_white;
draw_set_color(pass_col);
var pass_display = string_repeat("*", string_length(password_input));
draw_text(field_x, cy + 30, pass_display + ((state == "password" && (current_time div 400) mod 2 == 0) ? "_" : ""));

if (state == "confirm") {
    draw_set_color(c_lime);
    draw_set_halign(fa_center);
    draw_text(cx, cy + 65, "Pulsa Z para entrar");
    draw_text(cx, cy + 85, "Pulsa X para volver");
}

if (error_msg != "") {
    draw_set_color(c_red);
    draw_set_halign(fa_center);
    draw_text(cx, cy + 110, error_msg);
}

if (status_msg != "") {
    draw_set_color(c_yellow);
    draw_set_halign(fa_center);
    draw_text(cx, cy + 110, status_msg);
}

draw_set_halign(fa_left);
draw_set_color(c_white);

draw_set_color(make_color_rgb(120, 120, 120));
draw_set_halign(fa_center);
draw_text(cx, display_get_gui_height() - 20, "ESC para volver");
draw_set_color(c_white);