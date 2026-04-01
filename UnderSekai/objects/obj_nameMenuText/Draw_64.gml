var name_x = floor(100);
var name_y = floor(150);

draw_set_color(c_white);

var final_scale = name_scale * key_pop;

draw_text_transformed(
    name_x,
    name_y,
    parent.text_input,
    final_scale,
    final_scale,
    0
);
var w = string_width(parent.text_input) * final_scale;


// CURSOR
if (parent.menu_state == MenuState.INPUT) {
    if ((cursor_timer div 30) mod 2 == 0) {
        draw_text(name_x + w + 4, name_y, "_");
    }
}