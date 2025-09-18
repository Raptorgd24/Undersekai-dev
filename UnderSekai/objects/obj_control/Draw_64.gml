// --------------------- DRAW GUI ---------------------
if (global.dialogue_active) {
    // Caja de diálogo
    draw_sprite(spr_dialoguebox, 0, 0, 105);

    // Cara del personaje (solo si hay)
    if (global.dialogue_sprite != noone) {
        draw_sprite_ext(global.dialogue_sprite, global.dialogue_face, 54, 350, 2.3, 2.3, 0, $FFFFFF, 1);
    }

    // Texto
    draw_set_font(global.dialogue_font);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    var visible_text = string_copy(global.dialogue_text, 1, global.dialogue_index);

    // Si hay cara, texto más a la derecha, si no hay, pegado a la caja
    var text_x = (global.dialogue_sprite != spr_noone) ? 160 : 64;
    draw_text(text_x, 340, visible_text);
}
