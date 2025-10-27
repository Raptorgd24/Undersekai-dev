/// @description Inserte aquí la descripción
// Puede escribir su código en este editor
// obj_gameover_controller - Alarm[0]

// Rompemos el corazón y cambiamos sprite
with (obj_heart) {
    audio_play_sound(snd_heart_shatter, 1, false);
    sprite_index = spr_heart_shatter;
	x -=2;
	
}

// Espera un poco (0.5 segundos más o lo que quieras)
alarm[1] = room_speed * 1.5;
