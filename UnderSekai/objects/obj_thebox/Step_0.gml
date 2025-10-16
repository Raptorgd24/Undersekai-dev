/// @description Inserte aquí la descripción
// Puede escribir su código en este editor
if (text_index < string_length(text)) {
    timer += 1;
    if (timer >= text_speed) {
		audio_play_sound(snd_txt2,1,false);
        timer = 0;
        text_index += 1;
        display_text = string_copy(text, 1, text_index);
    }
}
