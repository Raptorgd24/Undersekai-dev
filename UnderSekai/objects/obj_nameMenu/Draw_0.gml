var start_x = 100;
var start_y = 200;
var spacing_x = 32;
var spacing_y = 32;


// TECLADO
if (menu_state == MenuState.INPUT) {

    for (var r = 0; r < array_length(keyboard); r++) {
        for (var c = 0; c < array_length(keyboard[r]); c++) {

            var key = keyboard[r][c];

            var xe = start_x + c * spacing_x;
            var ye = start_y + r * spacing_y;

            if (key == "RETURN") {
                xe += 40;
            }

            var selected = (r == row && c == col);

            draw_set_color(selected ? c_yellow : c_white);
            draw_text(floor(xe + 4), floor(ye + 4), key);
            draw_set_color(c_white);
        }
    }
}


// NOMBRE
var name_x = floor(100);
var name_y = floor(150);

draw_set_color(c_white);

var final_scale = name_scale * key_pop;

draw_text_transformed(
    name_x,
    name_y,
    text_input,
    final_scale,
    final_scale,
    0
);


// CURSOR
if (menu_state == MenuState.INPUT) {
    if ((cursor_timer div 30) mod 2 == 0) {
        draw_text(name_x + string_width(text_input) + 4, name_y, "_");
    }
}


// CONFIRM
if (menu_state == MenuState.CONFIRM) {

    var opt_y = 250;

    var accept_selected = (confirm_option == 0);
    var back_selected   = (confirm_option == 1);

    draw_set_color(accept_selected ? c_yellow : c_white);
    draw_text(100, opt_y, "ACCEPT");

    draw_set_color(back_selected ? c_yellow : c_white);
    draw_text(200, opt_y, "BACK");

    draw_set_color(c_white);
}


// FADE BLANCO
if (fade_alpha > 0) {
    draw_set_color(c_white);
    draw_set_alpha(fade_alpha);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1);
}