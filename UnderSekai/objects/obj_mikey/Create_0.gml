talk = 0;
function npc_dialogue()
{
    var dialogue_struct = {
        messages: [],
        release_move: true
    };

    array_push(dialogue_struct.messages, {
        text: "* Has recogido la Llave Miku.",
        character: "",
        face_index: 0,
        keep_box: false
    });

    dialogue_start(dialogue_struct);

    scr_giveitem("MikuLlave");
	scr_set_global_data("cogido_miku",true)
    instance_destroy();
}

if (scr_get_global_data("cogido_miku")) {
    instance_destroy();
}
