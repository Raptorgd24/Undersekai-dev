/// @desc Dibuja el HUD con sprites de barra de vida

var gui_x = x;
var gui_y = y;

// === Texto del nombre y LV ===
draw_set_font(ft_notdetermination);
draw_set_color(c_white);

// Nombre del jugador
draw_text(gui_x, gui_y, string(global.name));

// Nivel (LV)
draw_text(gui_x + spacing_name_lv, gui_y, "LV " + string(global.lv));

// === Texto “HP” ===
draw_text(gui_x + spacing_name_lv + spacing_lv_hp, gui_y, "HP");

// === Dibujar barra de vida ===
var ratio = global.health / global.maxHP;
var ratio_display = hp_display / global.maxHP;

// Coordenadas de la barra
var bar_x = gui_x + spacing_name_lv + spacing_lv_hp + spacing_hp_bar;
var bar_y = gui_y - 3; // un pequeño ajuste visual

// Fondo (vacío)
draw_sprite_ext(sprite_empty, 0, bar_x, bar_y, scale, scale, 0, c_white, 1);

// Barra amarilla (vida actual)
// La idea: recortar el sprite a una proporción según la vida
var full_width = bar_width * ratio_display;
if (full_width > 0) {
    draw_sprite_part_ext(sprite_full, 0, 0, 0, full_width, bar_height, bar_x, bar_y, scale, scale, c_white, 1);
}

// === Texto a la derecha (HP actual / Máximo) ===
draw_set_color(c_white);
var text_hp = string(floor(global.health)) + "/" + string(global.maxHP);
draw_text(bar_x + (bar_width * scale) + 20, gui_y, text_hp);

if (global.health < hp_display - 0.5) {
    // Si la vida visual es mayor que la real (o sea, perdió HP)
    if (floor(current_time / 100) mod 2 == 0) {
        draw_set_color(c_red);
        draw_text(bar_x + (bar_width * scale) + 20, gui_y, text_hp);
    }
}
