
function npc_dialogue() {

    var dialogue_struct = {
        messages: [],
        release_move: true
    };


        array_push(dialogue_struct.messages, {
            text: "* Es una foto de Miku.",
            character: "",
            face_index: 0,
            keep_box: true
        });

        array_push(dialogue_struct.messages, {
            text: "* Parece que es navidad.",
            character: "",
            face_index: 0,
            keep_box: false
        });

    dialogue_start(dialogue_struct);
}