function dialogue(_personaje, _cara, _mensaje, _seguir) {
    // Bloquear movimiento e interacción
    obj_player.can_move = false;
    obj_usable.can_use = false;
    
    // Activar diálogo
    global.dialogue_active = true;
    global.dialogue_text = _mensaje;
    global.dialogue_index = 0;
    global.dialogue_timer = 0;
    global.dialogue_keep = _seguir;
    global.dialogue_character = _personaje;

    // Sprite de cara (si existe)
    var spr_face = asset_get_index("spr_" + _personaje);
    if (spr_face != -1) {
        global.dialogue_sprite = spr_face;
        global.dialogue_face = _cara;
    } else {
        global.dialogue_sprite = spr_noone; // 👈 sin cara
    }

    // Fuente
    var ft = asset_get_index("ft_" + _personaje);
    if (ft != -1) {
        global.dialogue_font = ft;
    } else {
        global.dialogue_font = ft_determinationmono;
    }

    // Sonido
    var snd = asset_get_index("snd_" + string_lower(_personaje));
    if (snd != -1) {
        global.dialogue_sound = snd;
    } else {
        global.dialogue_sound = snd_txt1;
    }
}
