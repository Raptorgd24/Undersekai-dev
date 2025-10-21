// obj_attack_bar - Create
/// Barra que se mueve y el jugador debe parar con Z/Enter
moving = true;
stopped = false;
did_hit = false;
speed = 2;
sprite_index = spr_attack_bar;
image_speed = 0;
damage = 0;
center_x = 0;

// Coordenadas base (pueden inicializarse desde battle_id al crearse)
start_x = 0;
end_x = 0;
y_pos = 0;

battle_id = noone; // debe asignarlo obj_battle_menu al crear esta instancia

inited = false;

depth = -500;
image_xscale = 0.5;
image_yscale = 0.5;

draw_scale = 0.3;
image_blend = c_white;
precision =0;