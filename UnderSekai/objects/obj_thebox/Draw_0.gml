/// Draw Event

// Calculamos posición suavizada del dibujo
var draw_x = x + (target_x - x) * 0.1;
var draw_y = y + (target_y - y) * 0.1;

// Dibujamos el sprite nine-slice con tamaño tweened
draw_sprite_stretched(sprite_index, 0, draw_x, draw_y, box_width, box_height);
// Dibujamos la caja con tamaño fijo usando el sprite nine-slice
//draw_sprite_stretched(sprite_index, 0, x-21, y-138, box_width, box_height);

