// Los recursos de Script han cambiado para la v2.3.0 Consulta
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para más información
function scr_heal(healthlol, _antonio=false){
	if (_antonio){
		//overheal
		global.healthu += healthlol;
	} else{
		//normal
		global.healthu = min(global.healthu+healthlol,global.maxHP) 
	}
	audio_play_sound(snd_heal,1,false);
	show_debug_message(global.healthu);
}