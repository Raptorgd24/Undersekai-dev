// DRAW EVENT
// Dibujar sprite actual (si existe)
if (current_sprite != noone) {
    draw_sprite(current_sprite, 0, 130, 100);
}

// Dibujar texto
if (intro_state == "writing" || intro_state == "waiting") {
    draw_set_font(ft_determinationsans);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_text(intro_text_x, intro_text_y, intro_display_text);
}

// Dibujar fade final (si está activo)
if (intro_state == "final_fade" && fade_alpha > 0) {
    draw_set_alpha(fade_alpha);
    draw_sprite_stretched(spr_literalblack, 0, 0, 0, room_width, room_height);
    draw_set_alpha(1);
}