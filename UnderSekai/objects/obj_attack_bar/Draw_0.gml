// obj_attack_bar - Draw
/// Dibujo especial para la UI de barra (mantengo el draw_self para la barra)
layer_force_draw_depth(true, -901);

// Fondo (opcional): dibujar spr_attackthing si existe
var spr = spr_attackthing;
if (!variable_instance_exists(id, "draw_scale_x")) draw_scale_x = 0.3;
draw_scale_x = lerp(draw_scale_x, 0.48, 0.3);

var mid_x = (start_x + end_x) / 2;
var mid_y = y_pos;

if (sprite_exists(spr)) {
    var sw = sprite_get_width(spr), sh = sprite_get_height(spr);
    var draw_x = mid_x - (sw * draw_scale_x) * 0.5;
    var draw_y = mid_y - (sh * 1.0) * 0.5;
    draw_sprite_ext(spr, 0, draw_x + 0.5, draw_y + 62, draw_scale_x, 0.48, 0, c_white, 1);
}

// luego dibujar la barra encima
layer_force_draw_depth(true, -900);
draw_self();
