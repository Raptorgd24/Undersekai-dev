var start_x = 100;
var start_y = 200;
var spacing_x = 32;
var spacing_y = 32;

for (var r = 0; r < array_length(keyboard); r++) {
    for (var c = 0; c < array_length(keyboard[r]); c++) {

        var key = keyboard[r][c];
        var xe = start_x + c * spacing_x;
        var ye = start_y + r * spacing_y;

        var w = (key == "ENTER" || key == "RETURN") ? 80 : 24;
        var h = 24;

        // Selección
        if (r == row && c == col) {
            draw_rectangle(xe-4, ye-4, xe+w+4, ye+h+4, false);
        }

        draw_text(xe + 4, ye + 4, key);
    }
}

// Texto introducido
draw_text(100, 150, text_input);
