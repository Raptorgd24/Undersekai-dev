// Dibujar pantalla negra si corresponde
if (black_alpha > 0) {
	layer_force_draw_depth(true, -1)
    draw_set_alpha(black_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);
	
}
