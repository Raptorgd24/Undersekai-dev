// Create
image_alpha = 0;
//image_xscale = 0.25;
//image_yscale = 0.25;
fade_speed = 0.05;
scale_speed = 0.015;
/// Draw GUI Event

var gui_x = x;
var gui_y = y;

// Por ejemplo, escalar un 50%
var scale = 50;

// Dibujar el sprite manualmente
draw_sprite_ext(sprite_index, image_index, gui_x, gui_y, scale, scale, image_angle, image_blend, image_alpha);
image_xscale = 2
image_yscale = 2