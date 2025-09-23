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

    // --- función local: word wrap (usa string_split para GMS2) ---
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
                    var rest = w;
                    while (string_length(rest) > 0) {
                        cur = "";
                        var c = 1;
                        while (c <= string_length(rest) && string_width(string_copy(rest, 1, c)) <= _wrap_width) {
                            c += 1;
                        }
                        // c ahora apunta a primer char que haría overflow (o a len+1)
                        if (c == 1) {
                            // incluso un solo caracter excede el ancho (extremo); forzamos 1 char
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

if (instance_exists(obj_player)) {
    var cam = view_camera[0];
    var view_y = camera_get_view_y(cam);
    var view_h = camera_get_view_height(cam);
    var cam_mid_y = view_y + view_h/2;

    use_legacy = (obj_player.y < cam_mid_y);

    if (global.debug){
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();
    var mid_y_gui = gui_h/2;
    draw_set_color(c_red);
    draw_line(0, mid_y_gui, gui_w, mid_y_gui);
    draw_set_color(c_white);
    draw_text(32, mid_y_gui - 16, "Centro view (mundo Y=" + string(cam_mid_y) + ")");
	}
}



    // Valores "originales" (legacy) que pediste: caja en x=0,y=105; cara y texto en posiciones fijas
    var legacy_box_x = 0;
    var legacy_box_y = 105;
    var legacy_face_x = 54;
    var legacy_face_y = 350;
    var legacy_text_x_with_face = 160;
    var legacy_text_x_no_face = 64;
    var legacy_text_y = 340;

    // Si estamos en modo legacy usamos esos; si no, restamos 300 a las Y (misma X)
    var base_x, base_y;
    var face_x, face_y;
    var text_x, text_y;


	// Ajuste si no hay sprite de personaje o si es "noone"
	var extra_offset = 0;
	var extra_margin = 0;

	if (global.dialogue_sprite == noone || string(global.dialogue_character) == "noone") {
	    extra_offset = -100;   // mover 100px a la izquierda
	    extra_margin = 100;    // aumentar margen de texto
	}



    if (use_legacy) {
        base_x = legacy_box_x;
        base_y = legacy_box_y;
        face_x = legacy_face_x;
        face_y = legacy_face_y;
		text_x = (variable_global_exists("dialogue_sprite") && global.dialogue_sprite != noone)
		         ? legacy_text_x_with_face : legacy_text_x_no_face;
		text_x += extra_offset;

		var wrap_w = box_w - (text_x - base_x) - margin - extra_margin;

        text_y = legacy_text_y;
    } else {
        base_x = legacy_box_x;
        base_y = legacy_box_y - 300;
        face_x = legacy_face_x;
        face_y = legacy_face_y - 300;
        text_x = (variable_global_exists("dialogue_sprite") && global.dialogue_sprite != noone)
		         ? legacy_text_x_with_face : legacy_text_x_no_face;
				 
	text_x += extra_offset;
	var wrap_w = box_w - (text_x - base_x) - margin - extra_margin;


        text_y = legacy_text_y - 300;
    }

    // Ajustes: si no existe sprite caja, fallback para box_w y base_x centrado
    if (spr_idx == -1) {
        // Si no hay sprite de caja y no hay cámara/jugador, centramos por seguridad
        if (!instance_exists(obj_cam) || !instance_exists(obj_player)) {
            base_x = (gui_w - box_w) / 2;
            base_y = gui_h - box_h_default - margin;
            // recalcular text_x relativo al base_x
            text_x = base_x + margin + ((variable_global_exists("dialogue_sprite") && global.dialogue_sprite != noone) ? 160 : 64);
            text_y = base_y +  (legacy_text_y - legacy_box_y); // preserve relative offset
        } else {
            // si no hay sprite pero sí legacy coords, keep legacy x (0) as requested
        }
    }

    // --- Para wrap necesitamos un ancho disponible ---
    // Calculamos ancho disponible tomando box_w y la posición text_x relativa al base_x
    var rel_text_x = text_x - base_x;
    if (rel_text_x < 0) rel_text_x = margin;
    var wrap_w = box_w - rel_text_x - margin;
    if (wrap_w < 40) wrap_w = box_w - margin*2;

    // Generar líneas a partir del texto visible
    var lines = _string_wrap(visible_text, wrap_w);

    // Altura de línea y cálculo del bloque de texto (esto solo afecta a multi-líneas)
    var line_h = string_height("Ay");
    var padding_v = 12;
    var text_block_h = max(1, array_length(lines)) * line_h;
    var box_h = (spr_idx != -1) ? sprite_get_height(spr_idx) : (text_block_h + padding_v*2);

    // --- Dibujar caja ---
    if (spr_idx != -1) {
        // Dibujar la sprite de la caja con la misma posición legacy (usa el origen del sprite)
        draw_sprite(spr_idx, 0, base_x, base_y);
    } else {
        draw_set_alpha(0.9);
        draw_rectangle(base_x, base_y, base_x + box_w, base_y + box_h, false);
        draw_set_alpha(1);
    }

    // --- Dibujar cara (si hay) ---
    var face_sprite = (variable_global_exists("dialogue_sprite") ? global.dialogue_sprite : noone);
    if (face_sprite != noone) {
        draw_sprite_ext(face_sprite, global.dialogue_face, face_x, face_y, 2.3, 2.3, 0, $FFFFFF, 1);
    }

    // --- Dibujar texto (líneas) ---
    if (variable_global_exists("dialogue_font")) draw_set_font(global.dialogue_font);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    var start_x = text_x;
    var start_y = text_y;

    for (var li = 0; li < array_length(lines); li++) {
        draw_text(start_x, start_y + li * line_h, lines[li]);
    }

    // Indicador de "continuar"
    if (!global.dialogue_keep && global.dialogue_index >= string_length(global.dialogue_text)) {
        var cx = base_x + box_w - margin - 12;
        var cy = base_y + box_h - margin - 8;
        draw_triangle(cx, cy, cx+8, cy, cx+4, cy+8, false);
    }
}

if (global.debug){
// ---------------- DEBUG: línea en el medio de la cámara ----------------
if (instance_exists(obj_cam)) {
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();

    // Dibujar una línea horizontal en la mitad de la vista de la cámara
    var mid_y = gui_h / 2;
    draw_set_color(c_red);
    draw_line(0, mid_y, gui_w, mid_y);
    draw_set_color(c_white);

    // Texto con posiciones
    draw_text(32, mid_y - 16, "Centro camara (Y gui: " + string(mid_y) + ")");
}
}