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
                // palabra más grande que el margen → cortar por caracteres
                var cur = "";
                for (var c = 1; c <= string_length(w); c++) {
                    cur = string_copy(w, 1, c);
                    if (string_width(cur) > _wrap_width) {
                        array_push(lines, string_copy(w, 1, c-1));
                        w = string_copy(w, c, string_length(w)-(c-1));
                        c = 0;
                    }
                }
                line = w;
            }
        } else {
            line = test;
        }
    }
    if (line != "") array_push(lines, line);
    return lines;
}


    // Reservar espacio si hay cara
    var face_w = 0;
    var face_sprite = (variable_global_exists("dialogue_sprite") ? global.dialogue_sprite : noone);
    if (face_sprite != noone) {
        face_w = sprite_get_width(face_sprite) * 2.3;
    }

    // Ancho de texto disponible
    var wrap_w = box_w - margin*2 - face_w;
    if (wrap_w < 40) wrap_w = box_w - margin*2;

    // Generar líneas
    var lines = _string_wrap(visible_text, wrap_w);

    // Altura caja
    var line_h = string_height("Ay");
    var text_block_h = max(1, array_length(lines)) * line_h;
    var padding_v = 12;
    var box_h = (spr_idx != -1) ? sprite_get_height(spr_idx) : (text_block_h + padding_v*2);

    // Arriba o abajo según Y
    var show_bottom = false;
    if (instance_exists(obj_player) && instance_exists(obj_cam)) {
        show_bottom = (obj_player.y < obj_cam.y);
    } else {
        show_bottom = true;
    }

    // 🔹 AHORA: alineado a la izquierda
    var base_x = margin;
    var base_y = (show_bottom) ? (gui_h - box_h - margin) : margin;

    // Dibujar caja
    if (spr_idx != -1) {
        draw_sprite(spr_idx, 0, base_x, base_y); // ojo: sprite debería estar alineado desde top-left
    } else {
        draw_set_alpha(0.9);
        draw_rectangle(base_x, base_y, base_x + box_w, base_y + box_h, false);
        draw_set_alpha(1);
    }

    // Cara
    if (face_sprite != noone) {
        var face_x = base_x + margin + (sprite_get_width(face_sprite)*2.3)/2;
        var face_y = base_y + box_h/2;
        draw_sprite_ext(face_sprite, global.dialogue_face, face_x, face_y, 2.3, 2.3, 0, $FFFFFF, 1);
    }

    // Texto
    if (variable_global_exists("dialogue_font")) draw_set_font(global.dialogue_font);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    var text_x = margin + (global.dialogue_sprite != spr_noone) ? 160 : 64;;
	
    var text_y = base_y + padding_v;

    for (var li = 0; li < array_length(lines); li++) {
        draw_text(text_x, text_y + li * line_h, lines[li]);
    }

    // Indicador de "continuar"
    if (!global.dialogue_keep && global.dialogue_index >= string_length(global.dialogue_text)) {
        var cx = base_x + box_w - margin - 12;
        var cy = base_y + box_h - margin - 8;
        draw_triangle(cx, cy, cx+8, cy, cx+4, cy+8, false);
    }
}
