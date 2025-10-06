draw_set_font(font_menu);

for (var i = 0; i < array_length(menu_options); i++) {
    var txt = menu_options[i];
    var yy = 360 + (i * menu_spacing);
    
    // Si está seleccionado → color amarillo
    if (i == menu_index) {
        draw_set_color(c_yellow);
        draw_text(menu_x+30, yy, "  " + txt);
    } else {
        draw_set_color(c_white);
        draw_text(menu_x+25, yy, "  " + txt);
    }
}

// Restaurar color (por seguridad)
draw_set_color(c_white);
