/// @desc Inicializa el HUD de salud del jugador

// Posición del HUD (ajustable)
x = 50;
y = 386;

// Escala visual
scale = 3;

// Para animar los cambios de vida suavemente
hp_display = global.healthu;


// Configuración de sprites
sprite_full = spr_health;
sprite_empty = spr_nohealth;

// Tamaño base de la barra (según el sprite base)
base_bar_width = sprite_get_width(sprite_full);
base_bar_height = sprite_get_height(sprite_full);

// Interpolación del HP visual
hp_display = global.healthu;

// Separación entre elementos
spacing_name_lv = 150;
spacing_lv_hp = 80;
spacing_hp_bar = 50;

// Profundidad
depth = -999999; // Siempre visible por encima
// Factor de longitud: controla cuántos píxeles por punto de HP
// 20 HP = 16 px → 16 / 20 = 0.8 px por HP
px_per_hp = 0.7;
