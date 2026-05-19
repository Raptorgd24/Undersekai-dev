// obj_sing_note - Draw

draw_self();

// Dibujar nombre de la nota
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_text(x, y, lane);

// Mostrar accuracy si fue golpeada
if (show_accuracy) {
    draw_set_color(c_yellow);
    draw_text(x, y - 20, hit_accuracy);
}

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
