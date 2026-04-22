// ================= DRAW GUI =================
draw_set_alpha(0.35);
draw_set_color(c_white);
draw_circle(joy_x, joy_y, joy_r, false);           // Base joystick

draw_set_alpha(1);
draw_set_color(c_yellow);
draw_circle(stick_x, stick_y, stick_r, false);     // Stick

// Botones
var bx = btn_x;
var by = btn_y;
var s  = btn_size;

// Z rojo
draw_set_color(c_red);
draw_rectangle(bx, by, bx + s, by + s, false);
draw_set_color(c_white);
draw_text(bx + s/2 - 12, by + s/2 - 12, "Z");

// X azul
draw_set_color(c_blue);
draw_rectangle(bx + s, by, bx + s*2, by + s, false);
draw_set_color(c_white);
draw_text(bx + s + s/2 - 12, by + s/2 - 12, "X");

// C verde
draw_set_color(c_green);
draw_rectangle(bx + s*2, by, bx + s*3, by + s, false);
draw_set_color(c_white);
draw_text(bx + s*2 + s/2 - 12, by + s/2 - 12, "C");

draw_set_alpha(1);
draw_set_color(c_white);