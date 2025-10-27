if (black_alpha > 0) {
	layer_force_draw_depth(true, -1)
    draw_set_alpha(black_alpha);
    draw_set_color(c_black);
    draw_rectangle(obj_player.x-700, obj_player.y-700, 5000, 5000, false);
    draw_set_alpha(1);
	
}
