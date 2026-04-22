function scr_startdialogue(_battle_id, _starting_index = undefined){
show_debug_message(_battle_id);
show_debug_message(_starting_index);

if (!instance_exists(_battle_id)) return;
if (instance_exists(obj_thebox)) {
    with (obj_thebox) {
        text = "";
        display_text = "";
        text_index = 0;
    }
}
with (_battle_id) {

    if (!is_undefined(_starting_index)) dialogue_index = _starting_index;

    // 🚨 NO DIALOGO
    if (dialogue_index < 0) {
        mode = "enemy_turn";
        alarm[2] = 1;
        return;
    }

    mode = "dialogue";

    dialogue_data = scr_getbattletext(dialogue_index, hit_count);

    if (dialogue_data.text == "") {
        alarm[2] = 1;
        return;
    }

    // crear caja
    dialogue_box = instance_create_layer(0, 0, "Instances", obj_enemybubbl);

    if (instance_exists(dialogue_box)) {
        dialogue_box.enemy_id = theEnemy;
        dialogue_box.text = dialogue_data.text;
        dialogue_box.display_text = "";
        dialogue_box.text_index = 0;
        dialogue_box.voice = dialogue_data.voice;
    }

    // cara
    if (instance_exists(theEnemy) && theEnemy.object_index == obj_sans) {
        theEnemy.image_index = dialogue_data.face;
    }
}
}