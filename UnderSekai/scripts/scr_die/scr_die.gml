// Los recursos de Script han cambiado para la v2.3.0 Consulta
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para más información
function scr_die(){
 if (!instance_exists(obj_heart)){
 instance_create_layer(obj_player.x,obj_player.y,"Instances",obj_heart)
 obj_heart.dead = true;
 }
 if (instance_exists(obj_player)){
 instance_destroy(obj_player)
 }
 audio_stop_all()
 
 
 
 
 room_goto(rm_gameOver)
}