// obj_sing_ui - Draw

if (sing_manager == noone || !instance_exists(sing_manager)) return;

draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);

// Dibujar combo
draw_text(combo_x, combo_y, "Combo: " + string(sing_manager.combo));

// Dibujar máximo combo
draw_text(combo_x, combo_y + 25, "Max: " + string(sing_manager.max_combo));

// Dibujar score total
draw_text(score_x, score_y, "Score: " + string(sing_manager.total_score));

// Dibujar línea de hit (zona de presición)
draw_set_color(c_yellow);
draw_line(50, 450, 390, 450);

// Dibujar zonas de lanes
draw_set_color(c_gray);
draw_line_width(80, 420, 80, 480, 3);
draw_line_width(160, 420, 160, 480, 3);
draw_line_width(240, 420, 240, 480, 3);
draw_line_width(320, 420, 320, 480, 3);

// Dibujar labels de lanes
draw_set_color(c_white);
draw_text(80, 485, "D");
draw_text(160, 485, "F");
draw_text(240, 485, "J");
draw_text(320, 485, "K");

draw_set_halign(fa_left);
draw_set_valign(fa_top);
