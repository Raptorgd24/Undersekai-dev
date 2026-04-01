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

			if (key == "ENTER") {
				xe = start_x + 0 * spacing_x;
			}

			if (key == "RETURN") {
				xe = start_x + 3 * spacing_x; 
			}

            var selected = (r == row && c == col);

            draw_set_color(selected ? c_yellow : c_white);
            draw_text(floor(xe + 4), floor(ye + 4), key);
            draw_set_color(c_white);
        }
    }
}

// CONFIRM OPCIONES
if (menu_state == MenuState.CONFIRM) {

    var opt_y = 250;

    draw_set_color(confirm_option == 0 ? c_yellow : c_white);
    draw_text(100, opt_y, "ACCEPT");

    draw_set_color(confirm_option == 1 ? c_yellow : c_white);
    draw_text(200, opt_y, "BACK");

    draw_set_color(c_white);
}

// FADE
if (fade_alpha > 0) {
    draw_set_color(c_white);
    draw_set_alpha(fade_alpha);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1);
}