/// @description Inserte aquí la descripción
// Puede escribir su código en este editor
/// obj_dialoguebox - Step

// escritura tipo Undertale
if (text_index < string_length(text)) {
    timer++;
    if (timer >= text_speed) {
        timer = 0;
        text_index++;
        display_text = string_copy(text, 1, text_index);
        audio_play_sound(voice, 1, false);
    }
}

// seguir al enemigo (derecha)
if (instance_exists(enemy_id)) {
    x = enemy_id.bbox_right + 6;
    y = enemy_id.bbox_top + 4;
}
