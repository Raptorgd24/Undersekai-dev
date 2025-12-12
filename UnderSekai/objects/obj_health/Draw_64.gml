/// @desc Dibuja el HUD con sprites de barra de vida

var gui_xa = 50;
var gui_ya = 386;

// === Texto del nombre y LV ===
draw_set_font(ft_notdetermination);
draw_set_color(c_white);
draw_text(gui_xa, gui_ya, string(global.name));
draw_text(gui_xa + spacing_name_lv, gui_ya, "LV " + string(global.lv));
draw_text(gui_xa + spacing_name_lv + spacing_lv_hp, gui_ya, "HP");

// --- Parámetros de ancho ---
var px_per_hp = 0.7; // ancho en píxeles por cada punto de HP

// Ancho de fondo según maxHP
var width_nohealth = global.maxHP * px_per_hp;

// Ancho de barra amarilla según health
var width_health = global.healthu * px_per_hp;

// --- Fondo (spr_nohealth) ---
draw_sprite_stretched(
    spr_nohealth,
    0,
    gui_xa + 280,
    gui_ya - 3,
    width_nohealth * 2,       // ancho proporcional al maxHP
    sprite_get_height(spr_nohealth) * 3
);

// --- Barra amarilla (spr_health) ---
draw_sprite_stretched(
    spr_health,
    0,
    gui_xa + 280,
    gui_ya - 3,
    width_health * 2,         // ancho proporcional a health
    sprite_get_height(spr_health) * 3
);

// --- Texto de valores HP ---
draw_text(gui_xa + 280 + width_nohealth * 2 + 20, gui_ya, string(global.healthu) + "/" + string(global.maxHP));