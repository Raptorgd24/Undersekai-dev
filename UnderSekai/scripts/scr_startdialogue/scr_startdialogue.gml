// Los recursos de Script han cambiado para la v2.3.0 Consulta
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para más información
function scr_startdialogue(){
/// scr_start_enemy_dialogue()

mode = "dialogue";
dialogue_index = 0;

dialogue_data = scr_getbattletext(dialogue_index);

// crear caja
dialogue_box = instance_create_layer(0, 0, "Instances", obj_enemybubbl);
dialogue_box.enemy_id = theEnemy;
dialogue_box.text = dialogue_data.text;
dialogue_box.voice = dialogue_data.voice;

// aplicar cara
if (instance_exists(theEnemy)) {
	if (theEnemy = obj_sans){
		theEnemy.image_index = dialogue_data.face;
	}
}

}
