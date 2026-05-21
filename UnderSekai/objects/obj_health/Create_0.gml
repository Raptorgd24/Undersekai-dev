/// @desc Inicializa el HUD de salud del jugador

x = 50;
y = 386;

scale = 1;

hp_display = global.healthu;


sprite_full = spr_health;
sprite_empty = spr_nohealth;

base_bar_width = sprite_get_width(sprite_full);
base_bar_height = sprite_get_height(sprite_full);

hp_display = global.healthu;

spacing_name_lv = 150;
spacing_lv_hp = 80;
spacing_hp_bar = 50;

depth = -999; 
px_per_hp = 0.7;

cosonce = false;