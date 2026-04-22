function scr_draw_text_sprites(_x, _y, _text, _scale = 1, _color = c_white) {
    var len = string_length(_text);
    var current_x = _x;
    var current_y = _y;
    var line_height = 8 * _scale; // Ajusta según el alto de tus sprites
    
    for (var i = 1; i <= len; i++) {
        var char = string_char_at(_text, i);
        
        if (char == "\n") {
            current_x = _x;
            current_y += line_height;
            continue;
        }
        
        var spr_name = "spr_font_" + string_upper(char);
        var spr = asset_get_index(spr_name);
        
        if (spr != -1) {
            draw_sprite_ext(spr, 0, current_x, current_y, _scale, _scale, 0, _color, 1);
            current_x += sprite_get_width(spr) * _scale;
        } else if (char == " ") {
            current_x += 8 * _scale; // Espacio
        }
    }
}