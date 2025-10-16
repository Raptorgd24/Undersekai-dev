/// @desc Inicializa el HUD de salud del jugador

// Posición del HUD (ajustable)
x = 50;
y = 386;

// Escala visual
scale = 3;

// Datos del jugador (si no existen globales)
if (!variable_global_exists("name")) global.name = "Frisk";
if (!variable_global_exists("lv")) global.lv = 1;
if (!variable_global_exists("health")) global.health = 20;
if (!variable_global_exists("maxHP")) global.maxHP = 20;

// Para animar los cambios de vida suavemente
hp_display = global.health;

// Configuración de sprites
sprite_full = spr_health;
sprite_empty = spr_nohealth;

// Tamaño base de la barra (según el sprite base)
bar_width = sprite_get_width(sprite_full);
bar_height = sprite_get_height(sprite_full);

// Separación entre elementos
spacing_name_lv = 150;
spacing_lv_hp = 80;
spacing_hp_bar = 50;

// Profundidad
depth = -999999; // Siempre visible por encima
