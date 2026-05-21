talk = 0;
image_alpha = 0;
function npc_dialogue()
{
    var dialogue_struct = {
        messages: [],
        release_move: true
    };

    array_push(dialogue_struct.messages, {
        text: "* Has recogido un Microfono Usado.",
        character: "",
        face_index: 0,
        keep_box: false
    });

    dialogue_start(dialogue_struct);

    scr_giveitem("Micro");
	scr_set_global_data("cogido_micro",true)
    instance_destroy();
}

if (scr_get_global_data("cogido_micro")) {
    instance_destroy();
}