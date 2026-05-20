if (phase >= 1) {
    var alpha = (black_alpha >= 1) ? 1 : black_alpha;
    draw_sprite_ext(spr_heart, 0, heart_gui_x, heart_gui_y, 2, 2, 0, c_white, alpha);
}