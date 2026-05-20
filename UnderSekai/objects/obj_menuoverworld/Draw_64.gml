if (box_y >= display_get_gui_height()) exit;

draw_sprite_stretched(spr_blackboxtext, 0, box_x, box_y, box_w, box_h);

draw_set_font(ft_determinationsans);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var padding = 20;

if (state == "main") {
    var opt_start_y = box_y + padding;
    var opt_spacing = 36;

    for (var i = 0; i < array_length(main_options); i++) {
        var opt_x = box_x + padding + 20;
        var opt_y = opt_start_y + i * opt_spacing;

        if (i == main_index) {
            draw_set_color(c_white);
            draw_sprite_ext(spr_heart, 0, opt_x - 24, opt_y + 5, 2, 2, 0, c_white, 1);
        } else {
            draw_set_color(make_color_rgb(180, 180, 180));
        }

        draw_text(opt_x, opt_y, main_options[i]);
    }

    draw_set_color(c_white);
}

else if (state == "items") {
    var left_panel_w = box_w * 0.45;
    var right_panel_x = box_x + left_panel_w + padding;
    var right_panel_w = box_w - left_panel_w - padding * 2;

    var item_count = array_length(items);
    var list_start_y = box_y + padding;
    var list_spacing = 28;
    var visible_items = min(item_count, 8);
    var scroll_offset = max(0, item_index - 4);

    for (var i = 0; i < visible_items; i++) {
        var real_index = i + scroll_offset;
        if (real_index >= item_count) break;

        var item_name = items[real_index];
        var item_x = box_x + padding + 20;
        var item_y = list_start_y + i * list_spacing+12;

        if (real_index == item_index) {
            draw_set_color(c_white);
            draw_sprite_ext(spr_heart, 0, item_x - 24, item_y + 5, 2, 2, 0, c_white, 1);
        } else {
            draw_set_color(make_color_rgb(180, 180, 180));
        }

        draw_text(item_x, item_y, item_name);
    }

    draw_set_color(c_white);

    if (item_count > 0) {
        var current_item = items[item_index];
        var data = scr_item_data(current_item);

        if (!is_undefined(data)) {
            draw_set_color(c_yellow);
            draw_text(right_panel_x+75, box_y + padding, data.name);
            draw_set_color(c_white);

            var frame = 1;
            switch (current_item) {
                case "FoodTest":   frame = 2; break;
                case "WeaponTest": frame = 3; break;
                case "ArmorTest":  frame = 5; break;
                case "KeyTest":    frame = 6; break;
                case "Bandage":    frame = 8; break;
                case "Stick":    frame = 4; break;
            }

            var sprite_cx = right_panel_x + right_panel_w / 2;
            var sprite_cy = box_y + box_h / 2 - 10;
            draw_sprite_ext(spr_selitem, frame, sprite_cx, sprite_cy, 2, 2, 0, c_white, 1);

            draw_set_color(make_color_rgb(255, 255, 255));
            draw_text_ext(70, box_y + box_h - 45, data.desc, -1, right_panel_w);
            draw_set_color(c_white);
        }
    } else {
        draw_text(right_panel_x, box_y + box_h / 2, "No items.");
    }
}
else if (state == "options") {
    var padding = 20;
    var opt_y   = box_y + padding;
    var spacing = 38;

    if (options_confirm) {
        draw_set_color(c_white);
        draw_text(box_x + padding + 20, opt_y, "Are you sure?");

        var yes_x = box_x + padding + 20;
        var no_x  = box_x + padding + 130;
        var btn_y = opt_y + spacing;

        if (options_index == 0) {
            draw_set_color(c_yellow);
            draw_sprite_ext(spr_heart, 0, yes_x - 24, btn_y + 5, 2, 2, 0, c_white, 1);
        } else {
            draw_set_color(make_color_rgb(180, 180, 180));
        }
        draw_text(yes_x, btn_y, "YES");

        if (options_index == 1) {
            draw_set_color(c_yellow);
            draw_sprite_ext(spr_heart, 0, no_x - 24, btn_y + 5, 2, 2, 0, c_white, 1);
        } else {
            draw_set_color(make_color_rgb(180, 180, 180));
        }
        draw_text(no_x, btn_y, "NO");

        draw_set_color(c_white);
        exit;
    }

    for (var i = 0; i < array_length(options_list); i++) {
        var opt = options_list[i];
        var oy  = opt_y + i * spacing;
        var ox  = box_x + padding + 20;

        if (i == options_index) {
            draw_set_color(c_white);
            draw_sprite_ext(spr_heart, 0, ox - 24, oy + 5, 2, 2, 0, c_white, 1);
        } else {
            draw_set_color(make_color_rgb(180, 180, 180));
        }

        draw_text(ox, oy, opt);

        draw_set_color(c_white);

        if (opt == "RESOLUTION") {
            draw_text(ox + 170, oy, "< " + res_labels[global.opt_resolution] + " >");
        }
        if (opt == "FULLSCREEN") {
            draw_text(ox + 170, oy, global.opt_fullscreen ? "ON" : "OFF");
        }
        if (opt == "MASTER VOL") {
            draw_text(ox + 170, oy, "< " + string(round(global.opt_master_vol * 100)) + "% >");
        }
    }
}

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);