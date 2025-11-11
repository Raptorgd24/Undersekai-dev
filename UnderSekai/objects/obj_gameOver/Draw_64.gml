// Dibujar opciones del menú
if (room == rm_gameOver_screen) {
	
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var center_x = gui_w / 2;
var base_y = gui_h * 0.7;
for (var i = 0; i < array_length(menu_options); i++) {
    var option = menu_options[i];
    var xh= center_x + ((i - 0.5) * 200); // separación horizontal
    var yh = base_y;
    var col = (i == menu_index) ? color_selected : color_unselected;
    
    draw_set_color(col);
    draw_text(xh, yh, option);
}
// Dibujar fundido negro (transición)
if (fade_alpha > 0) {
    draw_set_alpha(fade_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_alpha(1);
}


}