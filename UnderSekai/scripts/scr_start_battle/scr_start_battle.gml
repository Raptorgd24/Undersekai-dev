function scr_start_battle(le_enemy){
/// @desc Inicia la secuencia de entrada a batalla
audio_play_sound(snd_666, 1, false);

// Crear el controlador de la transición
instance_create_layer(0, 0, "Instances", obj_battle_start_controller);
with (obj_battle_menu){
}
	enemy = le_enemy;
}