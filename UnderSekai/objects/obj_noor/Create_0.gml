talk = 0;
open = false;
if (scr_get_global_data("mikupuerta_abierta")) {
    open=true;
	image_index = 1;
	passable = true;
}
function npc_dialogue()
{
    var dialogue_struct = {
        messages: [],
        release_move: true
    };

    if (!open)
    {
        var item_index = scr_has_item("MikuLlave");
		show_debug_message(scr_has_item("MikuLLave"))
		
        if (item_index != -1)
        {
            array_push(dialogue_struct.messages, {
                text: "* Has usado la Llave Miku.",
                character: "",
                face_index: 0,
                keep_box: false
            });

            open = true;
			
			audio_play_sound(snd_noise, 1, false);
			scr_set_global_data("mikupuerta_abierta",true)
            array_delete(global.objects, item_index, 1);

            passable = true;
            image_index = 1;
        }
        else
        {
            array_push(dialogue_struct.messages, {
                text: "* Esta puerta necesita una llave.",
                character: "",
                face_index: 0,
                keep_box: false
            });
        }
    }

    dialogue_start(dialogue_struct);
}