// Dibuja el cuadro de fondo con el sprite resizable
var sw = sprite_get_width(spr_blackboxtext);
var sh = sprite_get_height(spr_blackboxtext);
draw_sprite_ext(spr_blackboxtext, 0, box_x, box_y, box_width / sw, box_height / sh, 0, c_white, 1);

// Dibuja el texto dentro del cuadro (alineado centrado, por ejemplo)
draw_set_font(ft_determinationsans);
draw_set_color(c_white);
var tx = box_x + 10;
var ty = box_y + 10;
draw_text(tx, ty, text_to_show);

// Dibuja las opciones:
var ox = box_x + 20;
var oy = box_y + 50;
for (var i = 0; i < array_length(opciones); i++) {
    var col = (i == seleccion) ? c_yellow : c_white;
    draw_set_color(col);
    draw_text(ox + i * 80, oy, opciones[i]);
}
