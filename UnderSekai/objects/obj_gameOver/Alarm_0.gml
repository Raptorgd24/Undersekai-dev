/// @description corazon cambio de sprite

with (obj_heart) {
    audio_play_sound(snd_heart_shatter, 1, false);
    sprite_index = spr_heart_shatter;
	x -=2;
	
}

alarm[1] = room_speed * 1.5;
