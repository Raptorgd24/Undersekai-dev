// obj_gameover - Draw GUI Event
if (room == rm_gameOver_screen) {
draw_set_font(font_menu);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var center_x = gui_w / 2;
var base_y = gui_h * 0.7;

// Dibujar los sprites del fondo
//draw_sprite_ext(spr_deadglow, 0, 0, 0,1,1,0,c_white,spr_glow_alpha);

draw_set_alpha(spr_ble_alpha);
draw_sprite(spr_ble, 0, 0, 0);



// Dibujar fundido negro (transición)
if (fade_alpha > 0) {
    draw_set_alpha(fade_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_alpha(1);
}
}