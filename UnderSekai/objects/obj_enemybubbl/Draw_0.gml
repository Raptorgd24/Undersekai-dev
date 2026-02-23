/// @description Inserte aquí la descripción
// Puede escribir su código en este editor
/// obj_dialoguebox - Draw

draw_sprite_stretched(sprite_index, 0, x, y, box_width, box_height);

draw_set_font(ft_determinationmono);
draw_set_color(c_black);
draw_text(x + text_offset_x, y + text_offset_y, display_text);
