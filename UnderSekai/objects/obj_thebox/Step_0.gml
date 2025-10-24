/// @description Inserte aquí la descripción
// obj_thebox step
if (text_index < string_length(text)) {
    timer += 1;
    if (timer >= text_speed) {
		audio_play_sound(snd_txt2,1,false);
        timer = 0;
        text_index += 1;
        display_text = string_copy(text, 1, text_index);
    }
}

box_width  += (target_width  - box_width)  * 0.1;
box_height += (target_height - box_height) * 0.1;
x += (target_x - x) * 0.1;
y += (target_y - y) * 0.1;

with (obj_heart){
box_left = obj_thebox.x;
box_right = obj_thebox.x + obj_thebox.box_width;
box_top = obj_thebox.y;
box_bottom = obj_thebox.y + obj_thebox.box_height;
}