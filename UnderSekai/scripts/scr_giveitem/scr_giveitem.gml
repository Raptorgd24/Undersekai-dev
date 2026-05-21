function scr_giveitem(_item = "FoodTest") {
    var _data = scr_item_data(_item);
    var _name = is_undefined(_data) ? _item : _data.name;
    
    array_push(global.objects, _item);
    audio_play_sound(snd_item, 1, false);
    
    var _dialogue = {
        messages: [
            {
                text: "Has recogido " + _name + ".",
                character: "",
                face_index: 0,
                keep_box: false
            }
        ],
        release_move: true
    };
    dialogue_start(_dialogue);
}