/// obj_attack_bar - Create
show_debug_message("obj_attack_bar - Create");

moving = true;
stopped = false;
did_hit = false;
speed = 2;
sprite_index = spr_attack_bar;
image_speed = 0; // sin animación mientras se mueve
damage = 0;
center_x = 0;

// coordenadas y límites (se intentarán inicializar desde battle_id en Step)
start_x = 0;
end_x = 0;
y_pos = 0;

// referencia al menu (se debe asignar desde obj_battle_menu al crear)
battle_id = noone;

show_debug_message("obj_attack_bar creado (battle_id inicial: " + string(battle_id) + ")");
depth = -500;
image_xscale = 0.5;
image_yscale = 0.5;

draw_scale = 0.3; // escala inicial X/Y