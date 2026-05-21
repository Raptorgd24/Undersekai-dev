
function npc_dialogue() {

    var dialogue_struct = {
        messages: [],
        release_move: true
    };


        array_push(dialogue_struct.messages, {
            text: "* Es un microfono desconectado.",
            character: "",
            face_index: 0,
            keep_box: true
        });


    dialogue_start(dialogue_struct);
}