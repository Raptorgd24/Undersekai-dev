/// @desc Dibuja el HUD con sprites de barra de vida

var gui_xa = 50;
var gui_ya = 386;

draw_set_font(ft_notdetermination);
draw_set_color(c_white);
draw_text(gui_xa, gui_ya, string(global.name));
draw_text(gui_xa + spacing_name_lv, gui_ya, "LV " + string(global.lv));
draw_text(gui_xa + spacing_name_lv + spacing_lv_hp, gui_ya, "HP");

var px_per_hp = 0.7; 

var width_nohealth = global.maxHP * px_per_hp;

var width_health = global.healthu * px_per_hp;

draw_sprite_stretched(
    spr_nohealth,
    0,
    gui_xa + 280,
    gui_ya - 3,
    width_nohealth * 2,       
    sprite_get_height(spr_nohealth) * 3
);

draw_sprite_stretched(
    spr_health,
    0,
    gui_xa + 280,
    gui_ya - 3,
    width_health * 2,        
    sprite_get_height(spr_health) * 3
);

draw_text(gui_xa + 280 + width_nohealth * 2 + 20, gui_ya, string(global.healthu) + "/" + string(global.maxHP));