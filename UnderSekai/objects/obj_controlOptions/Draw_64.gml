draw_set_font(font_menu);
gpu_set_texfilter(false);

var start_x = 40;
var start_y = 80;
var spacing = 36;

for (var i = 0; i < array_length(menu_options); i++) {
    var opt  = menu_options[i];
    var yy   = start_y + i * spacing;
    var col  = (i == menu_index) ? c_yellow : c_white;

    draw_set_color(col);
    draw_text(start_x + 20, yy, opt);

    draw_set_color(c_white);

    if (opt == "RESOLUTION") {
        draw_text(start_x + 200, yy, "< " + res_labels[global.opt_resolution] + " >");
    }
    if (opt == "FULLSCREEN") {
        draw_text(start_x + 200, yy, global.opt_fullscreen ? "ON" : "OFF");
    }
    if (opt == "MASTER VOL") {
        var vol_pct = string(round(global.opt_master_vol * 100)) + "%";
        draw_text(start_x + 200, yy, "< " + vol_pct + " >");
    }
}

draw_set_color(c_white);