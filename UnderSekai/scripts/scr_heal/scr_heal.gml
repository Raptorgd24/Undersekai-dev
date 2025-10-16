// Los recursos de Script han cambiado para la v2.3.0 Consulta
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para más información
function scr_heal(healthlol){
audio_play_sound(snd_heal,1,false);
global.healthu += healthlol;
show_debug_message(global.healthu);
}