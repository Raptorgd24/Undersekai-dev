/// obj_attack_bar - Draw
layer_force_draw_depth(true, -901);

// === Dibujar el sprite de fondo primero ===
var spr = spr_attackthing; // <- cambia por el nombre real si hace falta

// asegurar variable
if (!variable_instance_exists(id, "draw_scale_x")) draw_scale_x = 0.3;

// Lerp solo en X hacia 1.0
draw_scale_x = lerp(draw_scale_x, 0.48, 0.3); // ajusta el 0.3 para velocidad

// Determinar posición central (preferimos start_x/end_x o center_x si existen)
var mid_x;
var mid_y;
if (variable_instance_exists(id, "start_x") && variable_instance_exists(id, "end_x") && (start_x != 0 || end_x != 0)) {
    mid_x = (start_x + end_x) / 2;
} else if (variable_instance_exists(id, "center_x") && center_x != 0) {
    mid_x = center_x;
} else {
    mid_x = x;
}

if (variable_instance_exists(id, "y_pos") && y_pos != 0) {
    mid_y = y_pos;
} else {
    mid_y = y;
}

// Dibujar sprite centrado (solo escala X)
if (sprite_exists(spr)) {
    var sw = sprite_get_width(spr);
    var sh = sprite_get_height(spr);

    var draw_x = mid_x - (sw * draw_scale_x) * 0.5;
    var draw_y = mid_y - (sh * 1.0) * 0.5;

    draw_sprite_ext(spr, image_index, draw_x + 0.5, draw_y + 62, draw_scale_x, 0.48, 0, c_white, 1);
}

// === Luego dibujar el self (barra) encima ===
layer_force_draw_depth(true, -900);
draw_self();
