// --------------------- DRAW GUI (Dialog System) ---------------------
dialogue_draw(); // Usar el nuevo manager

	if (global.debug){
    draw_set_color(c_lime);
    draw_text(32, 24, global.current_zone);

    draw_set_color(c_white);
	}
// --- Dibujar transición ---
if (global.trans_active) {
    draw_set_alpha(global.trans_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);
}
