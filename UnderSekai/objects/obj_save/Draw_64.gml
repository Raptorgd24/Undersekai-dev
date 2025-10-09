if (!menu_visible) exit; // Solo mostrar después del diálogo

// Fondo del menú
if (asset_get_index("spr_blackboxtext") >= 0) {
    draw_sprite_stretched(spr_blackboxtext, 0, bx, by, box_w, box_h);
} else {
    draw_set_color(c_black);
    draw_rectangle(bx, by, bx + box_w, by + box_h, false);
}

// Fuente
if (asset_get_index("ft_determinationsans") >= 0)
    draw_set_font(ft_determinationsans);

// Color según estado
draw_set_color(saved_state ? c_yellow : c_white);

// Datos guardados actualmente en save.dat (o GUI actualizado tras Save)
draw_text(bx + gui_padding+10, by + gui_padding, save_name_gui);
draw_text(bx + box_w / 2 - 40, by + gui_padding, "LV " + string(save_lv_gui));

var total_s = floor(save_time_gui);
var minutes = floor(total_s / 60);
var seconds = total_s mod 60;
draw_text(bx + box_w - 150, by + gui_padding, string(minutes) + ":" + string_format(seconds, 2, 0));

draw_text(bx + gui_padding+10, by + gui_padding + 35, room_name_text);

// Opciones
var opt_y = by + box_h - 60;

if (saved_state) {
    draw_text(bx + 30, opt_y, "File saved");
} else {
    var save_x = bx + 100;
    var return_x = bx + 230;

    if (menu_index == 0) {
        draw_set_color(c_yellow);
        draw_text(save_x, opt_y, "Save");
        draw_set_color(c_white);
        draw_text(return_x, opt_y, "Return");
    } else {
        draw_set_color(c_white);
        draw_text(save_x, opt_y, "Save");
        draw_set_color(c_yellow);
        draw_text(return_x, opt_y, "Return");
    }

    var heart_x = (menu_index == 0) ? save_x - 18 : return_x - 18;
    if (asset_get_index("spr_heart") >= 0)
        draw_sprite(spr_heart, 0, heart_x, opt_y+5);
}
