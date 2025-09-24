// --------------------- DRAW GUI (Dialog System) ---------------------
if (variable_global_exists("dialogue_active") && global.dialogue_active) {

    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();
    var margin = 16;

    // Sprite caja
    var spr_idx = asset_get_index("spr_dialoguebox");
    var box_w = (spr_idx != -1) ? sprite_get_width(spr_idx) : (gui_w - margin*2);
    var box_h_default = 80;

    // Texto visible hasta ahora
    var visible_text = string_copy(global.dialogue_text, 1, global.dialogue_index);

    // --- función local: word wrap ---
    function _string_wrap(_text, _wrap_width) {
        var lines = [];
        if (_text == "") return lines;

        var words = string_split(_text, " ");
        var line = "";

        for (var i = 0; i < array_length(words); i++) {
            var w = words[i];
            var test = (line == "") ? w : line + " " + w;

            if (string_width(test) > _wrap_width) {
                if (line != "") {
                    array_push(lines, line);
                    line = w;
                } else {
                    // cortar palabra larga
                    var rest = w;
                    while (string_length(rest) > 0) {
                        var c = 1;
                        while (c <= string_length(rest) && string_width(string_copy(rest, 1, c)) <= _wrap_width) {
                            c += 1;
                        }
                        if (c == 1) {
                            array_push(lines, string_copy(rest, 1, 1));
                            rest = string_copy(rest, 2, string_length(rest)-1);
                        } else {
                            array_push(lines, string_copy(rest, 1, c-1));
                            rest = string_copy(rest, c, string_length(rest)-(c-1));
                        }
                    }
                    line = "";
                }
            } else {
                line = test;
            }
        }
        if (line != "") array_push(lines, line);
        return lines;
    }

    // --- Posición según cámara ---
    var use_legacy = true;
    if (instance_exists(obj_player)) {
        var cam = view_camera[0];
        if (!is_undefined(cam) && cam != -1) {
            var view_y = camera_get_view_y(cam);
            var view_h = camera_get_view_height(cam);
            var cam_mid_y = view_y + view_h/2;
            use_legacy = (obj_player.y < cam_mid_y);
        } else if (instance_exists(obj_cam)) {
            use_legacy = (obj_player.y < obj_cam.y);
        }
    }

    // Coordenadas originales
    var legacy_box_x = 0;
    var legacy_box_y = 105;
    var legacy_face_x = 54;
    var legacy_face_y = 350;
    var legacy_text_x_with_face = 160;
    var legacy_text_x_no_face   = 64;
    var legacy_text_y = 340;

    // Offset si no hay sprite o es noone
    var extra_offset = 0;
    var extra_margin = 0;
    var char_name = (variable_global_exists("dialogue_character") ? string(global.dialogue_character) : "noone");
    if (global.dialogue_sprite == noone || char_name == "noone") {
        extra_offset = -100;
        extra_margin = 100;
    }

    // Calcular posiciones
    var base_x, base_y, face_x, face_y, text_x, text_y;
    if (use_legacy) {
        base_x = legacy_box_x;
        base_y = legacy_box_y;
        face_x = legacy_face_x;
        face_y = legacy_face_y;
        text_x = (global.dialogue_sprite != noone) ? legacy_text_x_with_face : legacy_text_x_no_face;
        text_y = legacy_text_y;
    } else {
        base_x = legacy_box_x;
        base_y = legacy_box_y - 300;
        face_x = legacy_face_x;
        face_y = legacy_face_y - 300;
        text_x = (global.dialogue_sprite != noone) ? legacy_text_x_with_face : legacy_text_x_no_face;
        text_y = legacy_text_y - 300;
    }
    text_x += extra_offset;

    // Wrap width
    var rel_text_x = text_x - base_x;
    if (rel_text_x < 0) rel_text_x = margin;
    var wrap_w = box_w - rel_text_x - 32 - extra_margin;
    if (wrap_w < 40) wrap_w = box_w - margin*2;

    // Generar líneas
    var lines = _string_wrap(visible_text, wrap_w);

    // Altura texto y caja
    var line_h = string_height("Ay");
    var padding_v = 12;
    var text_block_h = max(1, array_length(lines)) * line_h;
    var box_h = (spr_idx != -1) ? sprite_get_height(spr_idx) : (text_block_h + padding_v*2);

    // Dibujar caja
    if (spr_idx != -1) {
        draw_sprite(spr_idx, 0, base_x, base_y);
    } else {
        draw_set_alpha(0.9);
        draw_rectangle(base_x, base_y, base_x + box_w, base_y + box_h, false);
        draw_set_alpha(1);
    }

    // Dibujar cara
    var face_sprite = global.dialogue_sprite;
    if (face_sprite != noone) {
        draw_sprite_ext(face_sprite, global.dialogue_face, face_x, face_y, 2.3, 2.3, 0, $FFFFFF, 1);
    }

    // --- Fuente ---
    var font_to_use = (variable_global_exists("dialogue_font") ? global.dialogue_font : -1);
    if (is_undefined(font_to_use) || font_to_use == -1) {
        var df = asset_get_index("ft_determinationmono");
        if (df != -1) draw_set_font(df);
    } else if (is_string(font_to_use)) {
        var idx = asset_get_index(font_to_use);
        draw_set_font((idx != -1) ? idx : asset_get_index("ft_determinationmono"));
    } else {
        draw_set_font(font_to_use);
    }

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    // --- Texto estilo Undertale: * + margen 32 ---
    var start_x = text_x;
    var start_y = text_y;
	draw_set_color(c_white);
    for (var li = 0; li < array_length(lines); li++) {
        var line_str = lines[li];
        if (li == 0) {
            draw_text(start_x, start_y, "*");
            draw_text(start_x + 32, start_y, line_str);
        } else {
            draw_text(start_x + 32, start_y + li * line_h, line_str);
        }
    }

    // Indicador de "continuar"
    if (!global.dialogue_keep && global.dialogue_index >= string_length(global.dialogue_text)) {
        var cx = base_x + box_w - 32 - 12;
        var cy = base_y + box_h - margin - 8;
        draw_triangle(cx, cy, cx+8, cy, cx+4, cy+8, false);
    }

    // Debug

}
	if (global.debug){
    draw_set_color(c_lime);
    draw_text(32, 24, global.current_zone);

    draw_set_color(c_white);
	}
// --- Dibujar transición ---
if (global.trans_active) {
    draw_set_alpha(global.trans_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);
}
